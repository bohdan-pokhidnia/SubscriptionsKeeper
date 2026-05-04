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
}
