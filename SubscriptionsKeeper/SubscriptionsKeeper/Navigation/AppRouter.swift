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
    var presentedRoute: AppRoute?

    func push(_ route: any Hashable) {
        switch selectedTabItem {
        case .subscriptions:
            subscriptionsPath.append(route)
            
        case .calendar:
            calendarPath.append(route)
        }
    }

    func present(_ route: any Hashable) {
        guard let route = route as? AppRoute else { return }
        presentedRoute = route
    }

    func pop() {
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

    func dismiss() {
        presentedRoute = nil
    }
}
