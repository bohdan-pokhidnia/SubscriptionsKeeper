//
//  UserRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 30.04.2026.
//

import Foundation

protocol UserRepository {
    var currentCurrency: Currency { get set }
    var isEnableTimeSensitiveNotifications: Bool { get set }
    
    func showDashboardValues(for currency: Currency) -> Bool
}

@Observable
final class UserRepositoryImpl: UserRepository {
    var currentCurrency: Currency {
        didSet {
            localStore.save(currentCurrency, forKey: currencyKey)
        }
    }
    
    var isEnableTimeSensitiveNotifications: Bool {
        didSet {
            localStore.save(isEnableTimeSensitiveNotifications, forKey: timeSensitiveNotificationsKey)
        }
    }
    
    private let defaultCurrency: Currency = Currency.allCases.first ?? .usd
    private let defaultIsEnableTimeSensitiveNotifications = false
    private let currencyKey: String = "currency"
    private let timeSensitiveNotificationsKey: String = "currency"
    private let localStore = LocalStoreImpl()
    
    init() {
        self.currentCurrency = localStore.load(forKey: currencyKey) ?? defaultCurrency
        self.isEnableTimeSensitiveNotifications = localStore.load(forKey: timeSensitiveNotificationsKey) ?? defaultIsEnableTimeSensitiveNotifications
    }
    
    func showDashboardValues(for currency: Currency) -> Bool {
        currentCurrency != currency
    }
}
