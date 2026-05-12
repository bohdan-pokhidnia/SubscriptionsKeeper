//
//  NotificationsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 07.05.2026.
//

import SwiftUI

@Observable
final class NotificationsViewModel {
    private let subscriptionsRepository: SubscriptionsRepository
    private let userRepository: UserRepository
    private let notificationScheduler: NotificationScheduler

    private(set) var subscriptions: [Subscription] = []
    private var notificationStates: [UUID: Bool] = [:]
    private var notificationDates: [UUID: Date] = [:]

    init(
        subscriptionsRepository: SubscriptionsRepository,
        userRepository: UserRepository,
        notificationScheduler: NotificationScheduler
    ) {
        self.subscriptionsRepository = subscriptionsRepository
        self.userRepository = userRepository
        self.notificationScheduler = notificationScheduler
    }

    func onAppear() async {
        fetchSubscriptions()
        await syncScheduledNotifications()
    }

    func notificationBinding(for subscription: Subscription) -> Binding<Bool> {
        Binding(
            get: { self.notificationStates[subscription.id, default: false] },
            set: { [weak self] isOn in
                guard let self else { return }
                self.notificationStates[subscription.id] = isOn
                
                Task {
                    if isOn {
                        await self.scheduleNotification(for: subscription)
                    } else {
                        self.notificationScheduler.cancel(notificationIdentifier: subscription.id.uuidString)
                    }
                }
            }
        )
    }

    func notificationDateBinding(for subscription: Subscription) -> Binding<Date> {
        Binding(
            get: { self.notificationDates[subscription.id, default: subscription.nextPaymentDate] },
            set: { [weak self] date in
                guard let self else { return }
                self.notificationDates[subscription.id] = date
                guard self.notificationStates[subscription.id] == true else { return }
                Task {
                    self.notificationScheduler.cancel(notificationIdentifier: subscription.id.uuidString)
                    await self.scheduleNotification(for: subscription)
                }
            }
        )
    }
}

private extension NotificationsViewModel {
    @MainActor
    func fetchSubscriptions() {
        do throws(DatabaseError) {
            subscriptions = try subscriptionsRepository.fetchAll()

            for subscription in subscriptions {
                if notificationStates[subscription.id] == nil {
                    notificationStates[subscription.id] = false
                }

                if notificationDates[subscription.id] == nil {
                    notificationDates[subscription.id] = subscription.nextPaymentDate
                }
            }
        } catch {
            print("[dev] Error fetching subscriptions: \(error)")
        }
    }

    @MainActor
    func syncScheduledNotifications() async {
        let scheduled = await notificationScheduler.scheduledNotifications()

        var scheduledMap: [String: NotificationPresentation] = [:]
        for notification in scheduled {
            scheduledMap[notification.identifier] = notification
        }

        for subscription in subscriptions {
            let notification = scheduledMap[subscription.id.uuidString]
            notificationStates[subscription.id] = notification != nil

            if let notification,
               let date = Calendar.current.date(from: notification.dateComponents) {
                notificationDates[subscription.id] = date
            }
        }
    }

    @MainActor
    func scheduleNotification(for subscription: Subscription) async {
        guard let date = notificationDates[subscription.id] else { return }
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let isTimeSensitive = userRepository.isEnableTimeSensitiveNotifications
        let content = NotificationContent(
            title: subscription.name,
            body: "Payment is due soon",
            isTimeSensitive: isTimeSensitive
        )
        let presentation = NotificationPresentation(
            identifier: subscription.id.uuidString,
            content: content,
            options: [.alert, .sound, .badge],
            isRepeated: true,
            dateComponents: components
        )

        do {
            try await notificationScheduler.schedule(notification: presentation)
        } catch {
            notificationStates[subscription.id] = false
        }
    }
}
