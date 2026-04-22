//
//  MainView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

struct MainView: View {
    @State private var appRouter: AppRouter
    @State private var addSubscriptionViewModel: AddSubscriptionViewModel

    init() {
        let router = AppRouter()
        _appRouter = State(initialValue: router)
        _addSubscriptionViewModel = State(initialValue: AddSubscriptionViewModel(
            router: router,
            repository: SubscriptionsRepositoryImpl()
        ))
    }

    var body: some View {
        @Bindable var appRouter = appRouter
        TabView(selection: $appRouter.selectedTabItem) {
            Tab(
                "Subscriptions",
                systemImage: "list.bullet.rectangle",
                value: TabItem.subscriptions
            ) {
                NavigationStack(path: $appRouter.subscriptionsPath) {
                    SubscriptionsView(viewModel: SubscriptionsViewModel(router: appRouter))
                        .navigationDestination(for: SubscriptionPath.self) { route in
                            switch route {
                            case .newSubscription:
                                EmptyView()
                            }
                        }
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
        .sheet(item: $appRouter.presentedSubscriptionRoute, onDismiss: onSheetDismiss) { route in
            switch route {
            case .addSubscription:
                NavigationStack(path: $appRouter.sheetPath) {
                    AddSubscriptionView(viewModel: addSubscriptionViewModel)
                        .navigationDestination(for: SubscriptionPath.self) { route in
                            switch route {
                            case let .newSubscription(subscription):
                                NewSubscriptionView(viewModel: NewSubscriptionViewModel(subscription: subscription))
                            }
                        }
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.large])
            }
        }
    }

    private func onSheetDismiss() {
        appRouter.sheetPath = NavigationPath()
    }
}
