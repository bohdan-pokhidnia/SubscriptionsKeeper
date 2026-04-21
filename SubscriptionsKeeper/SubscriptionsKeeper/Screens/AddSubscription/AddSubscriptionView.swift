//
//  AddSubscriptionView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

import SwiftUI

struct AddSubscriptionView: View {
    @Bindable var viewModel: AddSubscriptionViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(viewModel.subscriptions, id: \.identifier) { subscription in
                        subscriptionView(
                            imageUrl: subscription.imageUrlString,
                            title: subscription.name,
                            action: {}
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .navigationTitle("Subscriptions")
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}

private extension AddSubscriptionView {
    func subscriptionView(
        imageUrl: String,
        title: String,
        action: @escaping (() -> Void)
    ) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                RemoteImageView(stringUrl: imageUrl)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondary.opacity(0.5))
            }
            .padding(16)
            .background(.white, in: RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AddSubscriptionView(
        viewModel: AddSubscriptionViewModel(repository: SubscriptionsRepositoryImpl())
    )
}
