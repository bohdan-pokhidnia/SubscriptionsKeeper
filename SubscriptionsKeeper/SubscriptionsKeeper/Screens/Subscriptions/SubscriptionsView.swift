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
        ScrollView {
            VStack(spacing: 16) {
                monthlyAverageCard
                
                emptyView
            }
        }
        .navigationTitle("SubscriptionsKeeper")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    
                } label: {
                    Image(systemName: "gear")
                }
                .tint(.purple)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                .tint(.purple)
            }
        }
    }
}

private extension SubscriptionsView {
    var monthlyAverageCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.88, green: 0.47, blue: 0.95),
                            Color(red: 0.98, green: 0.60, blue: 0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 8) {
                Text("MONTHLY AVERAGE")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white.opacity(0.9))

                Text("€0,00")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)

                HStack(spacing: 12) {
                    statBadge(title: "YEARLY", value: "€0,00")
                    statBadge(title: "SUBS.", value: "0")
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
        SubscriptionsView(viewModel: SubscriptionsViewModel(router: AppRouter()))
    }
}
