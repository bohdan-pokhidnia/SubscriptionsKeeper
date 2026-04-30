//
//  StoreRepositoryImpl.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 30.04.2026.
//

import Foundation

protocol LocalStore {
    func save<T: Codable>(_ value: T, forKey key: String)
    func load<T: Codable>(forKey key: String) -> T?
    func remove(forKey key: String)
}

@Observable
final class LocalStoreImpl: LocalStore {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save<T: Codable>(_ value: T, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key)
    }

    func load<T: Codable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
