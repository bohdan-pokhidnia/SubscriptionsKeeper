//
//  DefaultRemoteImageFailureView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

import SwiftUI

struct DefaultRemoteImageFailureView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray5))
            
            VStack(spacing: 4) {
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.secondary)
                
                Text("No image")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
    }
}
