//
//  SettingsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 29.04.2026.
//

import SwiftUI

@Observable
final class SettingsViewModel {
    var userRepository: UserRepository
    private let router: Router
    
    init(userRepository: UserRepository, router: Router) {
        self.userRepository = userRepository
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
