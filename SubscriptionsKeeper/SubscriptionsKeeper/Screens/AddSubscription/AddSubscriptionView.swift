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
                    subscriptionView(
                        iconName: "sparkles",
                        iconColor: Color(red: 0.85, green: 0.55, blue: 0.45),
                        title: "Claude Pro"
                    ) {
                        
                    }
                    
                    subscriptionView(
                        iconName: "sparkles",
                        iconColor: Color.black,
                        title: "ChatGPT"
                    ) {
                        
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            .navigationTitle("Subscriptions")
        }
    }
}

private extension AddSubscriptionView {
    func subscriptionView(
        iconName: String,
        iconColor: Color,
        title: String,
        action: @escaping (() -> Void)
    ) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(iconColor)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 28))
                        .foregroundStyle(.white)
                }
                
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
    AddSubscriptionView(viewModel: AddSubscriptionViewModel())
}
