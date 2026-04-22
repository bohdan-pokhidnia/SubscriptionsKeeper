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
    var sheetPath = NavigationPath()
    var presentedSubscriptionRoute: SubscriptionRoute?

    func push(_ route: any Hashable) {
        if presentedSubscriptionRoute != nil {
            sheetPath.append(route)
            return
        }
        switch selectedTabItem {
        case .subscriptions:
            subscriptionsPath.append(route)
            
        case .calendar:
            calendarPath.append(route)
        }
    }

    func present(_ route: any Hashable) {
        if let route = route as? SubscriptionRoute {
            presentedSubscriptionRoute = route
        }
    }

    func pop() {
        if presentedSubscriptionRoute != nil, !sheetPath.isEmpty {
            sheetPath.removeLast()
            return
        }
        
        switch selectedTabItem {
        case .subscriptions:
            if !subscriptionsPath.isEmpty {
                subscriptionsPath.removeLast()
            }
            
        case .calendar:
            if !calendarPath.isEmpty {
                calendarPath.removeLast()
            }
        }
    }
    
    func popToRoot() {
        switch selectedTabItem {
        case .subscriptions:
            subscriptionsPath = NavigationPath()

        case .calendar:
            calendarPath = NavigationPath()
        }
    }

    func dismiss() {
        presentedSubscriptionRoute = nil
    }
}
