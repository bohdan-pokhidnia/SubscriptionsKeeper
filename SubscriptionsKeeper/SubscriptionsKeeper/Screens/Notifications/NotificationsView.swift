//
//  NotificationsView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 07.05.2026.
//

import SwiftUI

struct NotificationsView: View {
    @Bindable var viewModel: NotificationsViewModel

    var body: some View {
        List {
            ForEach(viewModel.subscriptions) { subscription in
                SubscriptionNotificationView(
                    subscription: subscription,
                    isOn: viewModel.notificationBinding(for: subscription),
                    notificationDate: viewModel.notificationDateBinding(for: subscription)
                )
            }
        }
        .listStyle(.plain)
        .navigationTitle("Notifications")
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    NavigationStack {
        NotificationsView(
            viewModel: NotificationsViewModel(
                subscriptionsRepository: try! SubscriptionsRepositoryImpl(),
                userRepository: UserRepositoryImpl(),
                notificationScheduler: LocalNotificationScheduler()
            )
        )
    }
}
