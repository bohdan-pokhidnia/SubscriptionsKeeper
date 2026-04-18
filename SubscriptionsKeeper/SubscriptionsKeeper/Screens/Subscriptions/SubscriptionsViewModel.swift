//
//  SubscriptionsViewModel.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

@Observable
final class SubscriptionsViewModel {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
}
