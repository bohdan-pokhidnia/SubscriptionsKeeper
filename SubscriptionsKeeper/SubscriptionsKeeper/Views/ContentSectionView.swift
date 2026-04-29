//
//  ContentSectionView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 29.04.2026.
//

import SwiftUI

struct ContentSectionView<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
    }
}

struct ContentFieldView<Value: View>: View {
    let icon: String
    var iconColor: Color = .secondary
    let label: String
    @ViewBuilder let value: () -> Value

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .frame(width: 24, height: 24)

            Text(label)
                .font(.subheadline)
                .foregroundStyle(.primary)

            Spacer()

            value()
                .foregroundStyle(.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

struct ContentSectionDivider: View {
    var body: some View {
        Divider()
            .padding(.leading, 44)
    }
}
