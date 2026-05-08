//
//  SubscriptionNotificationView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 08.05.2026.
//

import SwiftUI

struct SubscriptionNotificationView: View {
    let subscription: Subscription
    @Binding var isOn: Bool

    private var nextPaymentSubtitle: String {
        subscription.nextPaymentDate.formatted(.dateTime.day().month(.abbreviated))
    }

    var body: some View {
        HStack(spacing: 12) {
            RemoteImageView(stringUrl: subscription.imageUrlString)
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.primary)

                Text(nextPaymentSubtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.purple)
        }
        .padding(12)
        .background(.background, in: RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
    }
}

#Preview {
    SubscriptionNotificationView(
        subscription: .preview(),
        isOn: .constant(true)
    )
    .padding()
}
