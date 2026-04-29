//
//  MainView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

import SwiftUI

struct MainView: View {
    @Environment(SubscriptionsRepositoryImpl.self) private var subscriptionsRepository
    @Bindable private var appRouter = AppRouter()
    @State private var subscriptionsViewModel: SubscriptionsViewModel?
    @State private var addSubscriptionViewModel: AddSubscriptionViewModel?

    var body: some View {
//        @Bindable var appRouter = appRouter
        
        TabView(selection: $appRouter.selectedTabItem) {
            Tab(
                "Subscriptions",
                systemImage: "list.bullet.rectangle",
                value: TabItem.subscriptions
            ) {
                NavigationStack(path: $appRouter.subscriptionsPath) {
                    if let subscriptionsViewModel {
                        SubscriptionsView(viewModel: subscriptionsViewModel)
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
            
            Tab(
                "Notifications",
                systemImage: "bell.badge",
                value: TabItem.notifications
            ) {
                Color.blue
            }
        }
        .tint(.purple)
        .task {
            if subscriptionsViewModel == nil {
                subscriptionsViewModel = SubscriptionsViewModel(repository: subscriptionsRepository, router: appRouter)
            }
            
            if addSubscriptionViewModel == nil {
                addSubscriptionViewModel = AddSubscriptionViewModel(repository: subscriptionsRepository, router: appRouter)
            }
        }
        .sheet(item: $appRouter.presentedRoute, onDismiss: onSheetDismiss) { route in
            switch route {
            case .addSubscription:
                if let viewModel = addSubscriptionViewModel {
                    NavigationStack(path: $appRouter.sheetPath) {
                        AddSubscriptionView(viewModel: viewModel)
                            .navigationDestination(for: PresentationRoute.self) { route in
                                switch route {
                                case let .newSubscription(subscription, mode):
                                    newSubscriptionView(subscription: subscription, mode: mode)
                                    
                                case .addSubscription, .details, .settings:
                                    EmptyView()
                                }
                            }
                    }
                }
                
            case let .newSubscription(subscription, mode):
                NavigationStack {
                    newSubscriptionView(subscription: subscription, mode: mode)
                }
                
            case let .details(subscription):
                NavigationStack {
                    SubscriptionDetailsView(
                        viewModel: SubscriptionDetailsViewModel(
                            repository: subscriptionsRepository,
                            router: appRouter,
                            subscription: subscription
                        )
                    )
                }
                
            case .settings:
                NavigationStack {
                    SettingsView(viewModel: SettingsViewModel(router: appRouter))
                }
                .presentationDragIndicator(.visible)
                .presentationDetents([.large, .medium])
            }
        }
        .fullScreenCover(item: $appRouter.fullScreenPresentedRoute, onDismiss: onSheetDismiss) { route in
            switch route {
            case let .details(subscription):
                NavigationStack {
                    SubscriptionDetailsView(
                        viewModel: SubscriptionDetailsViewModel(
                            repository: subscriptionsRepository,
                            router: appRouter,
                            subscription: subscription
                        )
                    )
                }
                
            case .addSubscription, .newSubscription, .settings:
                EmptyView()
            }
        }
    }
    
    private func newSubscriptionView(subscription: Subscription, mode: NewSubscriptionViewModel.Mode) -> some View {
        NewSubscriptionView(
            viewModel: NewSubscriptionViewModel(
                repository: subscriptionsRepository,
                router: appRouter,
                subscription: subscription,
                mode: mode
            )
        )
    }

    private func onSheetDismiss() {
        appRouter.sheetPath = NavigationPath()
        subscriptionsViewModel?.fetchSubscriptions()
    }
}
