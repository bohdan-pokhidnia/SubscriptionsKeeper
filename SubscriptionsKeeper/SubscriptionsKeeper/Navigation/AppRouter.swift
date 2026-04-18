//
//  AppRouter.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

@Observable
final class AppRouter: Router {
    var selectedTabItem: TabItem = .subscriptions
    var subscriptionsPath = NavigationPath()
    var calendarPath = NavigationPath()
    
    func push(_ route: any Hashable) {
        
    }
    
    func present(_ route: any Hashable) {
        
    }
    
    func pop() {
        
    }
}
