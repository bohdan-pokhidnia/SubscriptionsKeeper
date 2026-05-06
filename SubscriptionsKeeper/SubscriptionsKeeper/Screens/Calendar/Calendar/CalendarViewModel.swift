//
//  CalendarViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 04.05.2026.
//

import Foundation

@Observable
final class CalendarViewModel {
    var remainingCost: Double {
        subscriptions.reduce(0.0) { $0 + ($1.dashboardCost ?? $1.cost) }
    }

    var currency: Currency {
        userRepository.currentCurrency
    }

    var paymentsCount: Int {
        subscriptionsForCurrentMonth.count
    }

    var nextChargeDate: Date? {
        let componentsToday = calendar.dateComponents([.year, .month, .day], from: .now)

        return subscriptionsForCurrentMonth
            .compactMap { subscription -> Date? in
                let paymentDay = calendar.component(.day, from: subscription.firstPaymentAt)
                var components = calendar.dateComponents([.year, .month], from: today)
                components.day = paymentDay
                guard let date = calendar.date(from: components),
                      let todayDay = componentsToday.day,
                      paymentDay >= todayDay else {
                    return nil
                }
                return date
            }
            .min()
    }

    private var today: Date = .now
    private(set) var subscriptions: [Subscription] = []

    private let fetchDashboardSubscriptions: FetchDashboardSubscriptionsUseCase
    private let userRepository: UserRepository
    private let calendar = Calendar.current

    init(
        fetchDashboardSubscriptions: FetchDashboardSubscriptionsUseCase,
        userRepository: UserRepository
    ) {
        self.fetchDashboardSubscriptions = fetchDashboardSubscriptions
        self.userRepository = userRepository
    }

    func onAppear() async {
        await fetchSubscriptions()
    }

    private func fetchSubscriptions() async {
        do throws(DatabaseError) {
            subscriptions = try await fetchDashboardSubscriptions.execute()
        } catch {
            print("[dev] Error fetching subscriptions: \(error)")
        }
    }

    private var subscriptionsForCurrentMonth: [Subscription] {
        let monthComponents = calendar.dateComponents([.year, .month], from: today)
        return subscriptions.filter { subscription in
            let paymentDay = calendar.component(.day, from: subscription.firstPaymentAt)
            var components = monthComponents
            components.day = paymentDay
            return calendar.date(from: components) != nil
        }
    }
    /// Weekday short symbols ordered according to the user's system locale (e.g. Monday-first or Sunday-first)
    var weekdaySymbols: [String] {
        let symbols = calendar.veryShortWeekdaySymbols // ["S","M","T","W","T","F","S"] for en
        let startIndex = calendar.firstWeekday - 1     // 0-based
        return Array(symbols[startIndex...]) + Array(symbols[..<startIndex])
    }

    var monthTitle: String {
        today.formatted(.dateTime.month(.wide))
    }

    var yearTitle: String {
        today.formatted(.dateTime.year())
    }

    var daysInMonth: [DateComponents] {
        guard let range = calendar.range(of: .day, in: .month, for: today) else {
            return []
        }
        let components = calendar.dateComponents([.year, .month], from: today)
        return range.map {
            DateComponents(year: components.year, month: components.month, day: $0)
        }
    }

    /// Number of empty cells before the 1st day, respecting the system's first weekday setting
    var firstWeekdayOffset: Int {
        let components = calendar.dateComponents([.year, .month], from: today)
        guard let firstDay = calendar.date(from: components) else { return 0 }
        let weekday = calendar.component(.weekday, from: firstDay) // 1=Sunday, 2=Monday, ...
        // Shift relative to the user's first weekday
        return (weekday - calendar.firstWeekday + 7) % 7
    }

    func isToday(day: Int) -> Bool {
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let monthComponents = calendar.dateComponents([.year, .month], from: today)
        return components.year == monthComponents.year
            && components.month == monthComponents.month
            && components.day == day
    }

    func subscriptionsForDay(_ day: Int) -> [Subscription] {
        subscriptions.filter { subscription in
            let paymentDay = calendar.component(.day, from: subscription.firstPaymentAt)
            return paymentDay == day
        }
    }

    func goToPreviousMonth() {
        guard let newDate = calendar.date(byAdding: .month, value: -1, to: today) else {
            return
        }
        today = newDate
    }

    func goToNextMonth() {
        guard let newDate = calendar.date(byAdding: .month, value: 1, to: today) else {
            return
        }
        today = newDate
    }
}
