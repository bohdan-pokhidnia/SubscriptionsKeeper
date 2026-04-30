//
//  UserRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 30.04.2026.
//

import Foundation

protocol UserRepository {
    var currentCurrency: Currency { get set }
}

@Observable
final class UserRepositoryImpl: UserRepository {
    var currentCurrency: Currency {
        didSet {
            localStore.save(currentCurrency, forKey: currencyKey)
        }
    }
    
    private let defaultCurrency: Currency = Currency.allCases.first ?? .usd
    private let currencyKey: String = "currency"
    private let localStore = LocalStoreImpl()
    
    init() {
        self.currentCurrency = localStore.load(forKey: currencyKey) ?? defaultCurrency
    }
}
