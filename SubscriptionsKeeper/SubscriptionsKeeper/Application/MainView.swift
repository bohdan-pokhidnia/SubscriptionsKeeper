//
//  MainView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

struct MainView: View {
    @Bindable var router = AppRouter()
    
    var body: some View {
        TabView(selection: $router.selectedTabItem) {
            Tab(
                "Subscriptions",
                systemImage: "list.bullet.rectangle",
                value: TabItem.subscriptions
            ) {
                NavigationStack(path: $router.subscriptionsPath) {
                    SubscriptionsView(viewModel: SubscriptionsViewModel(router: router))
                }
            }

            Tab(
                "Calendar",
                systemImage: "calendar",
                value: TabItem.calendar
            ) {
                Color.green
            }
        }
        .tint(.purple)
    }
}
