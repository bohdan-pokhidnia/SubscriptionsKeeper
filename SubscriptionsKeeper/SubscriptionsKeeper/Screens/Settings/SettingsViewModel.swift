//
//  SettingsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 29.04.2026.
//

import SwiftUI

@Observable
final class SettingsViewModel {
    var currency: Currency = Currency.allCases.first ?? .usd
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func doneButtonTapped() {
        router.dismiss()
    }
    
    func privacyPolicyTapped() {
        //TODO: - add before release
    }
    
    func termsOfUseTapped() {
        //TODO: - add before release
    }
}
