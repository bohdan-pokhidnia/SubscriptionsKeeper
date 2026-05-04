//
//  RateRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 01.05.2026.
//

import Foundation

protocol RateRepository: RateAPI {
    func setup(currency: Currency) async throws(RateError)
}

@Observable
final class RateRepositoryImpl: RateRepository {
    private let frankfurterApi: RateAPI
    private let nbuAPI: RateAPI

    private var cachedRates: [Currency: [Rate]] = [:]
    private var cacheDate: Date?

    init() {
        frankfurterApi = FrankfurterAPI()
        nbuAPI = NBUAPI()
    }
    
    func setup(currency: Currency) async throws(RateError) {
        _ = try await fetchRate(baseCurrency: currency)
    }
    
    func fetchRate(baseCurrency: Currency) async throws(RateError) -> [Rate] {
        if let cacheDate, !Calendar.current.isDateInToday(cacheDate) {
            cachedRates.removeAll()
        }

        if let cached = cachedRates[baseCurrency] {
            return cached
        }
        
        var rates: [Rate] = []
        let nbuRates: [Rate] = try await nbuAPI.fetchRate(baseCurrency: baseCurrency)
        
        if baseCurrency == .uah {
            rates = nbuRates.map {
                Rate(baseCurrency: $0.baseCurrency, currency: $0.currency, amount: 1.0 / $0.amount)
            }
        } else {
            rates = try await frankfurterApi.fetchRate(baseCurrency: baseCurrency)
            
            if let uahRate = nbuRates.first(where: { $0.currency == baseCurrency }) {
                rates.append(Rate(baseCurrency: baseCurrency, currency: .uah, amount: uahRate.amount))
            }
        }

        cachedRates[baseCurrency] = rates
        cacheDate = .now
        return rates
    }
}
