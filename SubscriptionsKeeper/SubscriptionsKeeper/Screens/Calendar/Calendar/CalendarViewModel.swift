//
//  CalendarViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 04.05.2026.
//

import Foundation

@Observable
final class CalendarViewModel {
    var remainingCost: Double = 45.34
    var currency: Currency = .usd
    var paymentsCount: Int = 3
    var nextChargeDate: Date? = Calendar.current.date(from: DateComponents(year: 2026, month: 5, day: 10))

    var currentMonth: Date = .now
    var subscriptions: [Subscription] = []

    private let calendar = Calendar.current
    /// Weekday short symbols ordered according to the user's system locale (e.g. Monday-first or Sunday-first)
    var weekdaySymbols: [String] {
        let symbols = calendar.veryShortWeekdaySymbols // ["S","M","T","W","T","F","S"] for en
        let startIndex = calendar.firstWeekday - 1     // 0-based
        return Array(symbols[startIndex...]) + Array(symbols[..<startIndex])
    }

    var monthTitle: String {
        currentMonth.formatted(.dateTime.month(.wide))
    }

    var yearTitle: String {
        currentMonth.formatted(.dateTime.year())
    }

    var daysInMonth: [DateComponents] {
        guard let range = calendar.range(of: .day, in: .month, for: currentMonth) else {
            return []
        }
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        return range.map {
            DateComponents(year: components.year, month: components.month, day: $0)
        }
    }

    /// Number of empty cells before the 1st day, respecting the system's first weekday setting
    var firstWeekdayOffset: Int {
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        guard let firstDay = calendar.date(from: components) else { return 0 }
        let weekday = calendar.component(.weekday, from: firstDay) // 1=Sunday, 2=Monday, ...
        // Shift relative to the user's first weekday
        return (weekday - calendar.firstWeekday + 7) % 7
    }

    func isToday(day: Int) -> Bool {
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let monthComponents = calendar.dateComponents([.year, .month], from: currentMonth)
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
        guard let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) else {
            return
        }
        currentMonth = newDate
    }

    func goToNextMonth() {
        guard let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) else {
            return
        }
        currentMonth = newDate
    }
}
