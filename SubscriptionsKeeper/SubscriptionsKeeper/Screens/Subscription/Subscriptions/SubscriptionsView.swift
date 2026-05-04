//
//  SubscriptionsView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 17.04.2026.
//

import SwiftUI

struct SubscriptionsView: View {
    @Bindable var viewModel: SubscriptionsViewModel
    
    var body: some View {
        List {
            Section {
                monthlyAverageView
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)

            if viewModel.subscriptions.isEmpty {
                Section {
                    emptyView
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            } else {
                Section {
                    ForEach(viewModel.subscriptions) { subscription in
                        Button {
                            viewModel.subscriptionTapped(subscription)
                        } label: {
                            SubscriptionView(subscription: subscription)
                        }
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete { offsets in
                        viewModel.delete(at: offsets)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Subscriptions Keeper")
        .alert("Delete \(viewModel.removedSubscription?.name ?? "")?", isPresented: $viewModel.showDeleteAlert) {
            Button("Cancel", role: .cancel) {}

            Button("Delete", role: .destructive) {
                viewModel.deleteConfirmed()
            }
        } message: {
            Text("This subscription will be permanently removed.")
        }
        .tint(.blue)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.settingsButtonTapped()
                } label: {
                    Image(systemName: "gear")
                }
                .tint(.purple)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.addSubscriptionButtonTapped()
                } label: {
                    Image(systemName: "plus")
                }
                .tint(.purple)
            }
        }
        .task {
            await viewModel.onAppear()
        }
        .safeAreaPadding(.bottom, 24)
    }
}

private extension SubscriptionsView {
    var monthlyAverageView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(red: 0.82, green: 0.22, blue: 0.88), location: 0.0),
                            .init(color: Color(red: 0.94, green: 0.42, blue: 0.63), location: 0.5),
                            .init(color: Color(red: 0.90, green: 0.56, blue: 0.20), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 16) {
                Text("MONTHLY AVERAGE")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))

                Text(viewModel.monthlyAverage)
                    .font(.system(size: 58, weight: .bold))
                    .foregroundStyle(.white)

                HStack(spacing: 12) {
                    statBadge(title: "YEARLY", value: viewModel.yearly)
                    statBadge(title: "THIS MONTH", value: "€0,00")
                    statBadge(title: "SUBS.", value: viewModel.subscriptionsCount)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }

    func statBadge(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.8))

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
    }
    
    var emptyView: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.88, green: 0.30, blue: 0.78),
                                Color(red: 0.98, green: 0.60, blue: 0.55)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                Image(systemName: "creditcard")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
            }
            .padding(.top, 40)
            
            VStack(spacing: 12) {
                Text("No subscriptions yet")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text("Track Spotify, Netflix, iCloud\nand all your services in one place")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                viewModel.addSubscriptionButtonTapped()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text("Add subscription")
                        .font(.system(size: 18, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.55, green: 0.25, blue: 0.65),
                            Color(red: 0.85, green: 0.35, blue: 0.48)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    in: Capsule()
                )
                .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
            }
            .padding(.horizontal, 32)
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
    }
}

#Preview {
    NavigationStack {
        SubscriptionsView(
            viewModel: SubscriptionsViewModel(
                subscriptionsRepository: try! SubscriptionsRepositoryImpl(
                    userRepository: UserRepositoryImpl(),
                    rateRepository: RateRepositoryImpl()
                ),
                userRepository: UserRepositoryImpl(),
                rateRepository: RateRepositoryImpl(),
                router: AppRouter()
            )
        )
    }
}
