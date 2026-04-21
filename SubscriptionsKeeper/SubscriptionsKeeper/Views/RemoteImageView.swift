//
//  RemoteImageView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 21.04.2026.
//

import Kingfisher
import SwiftUI

struct RemoteImageView<Placeholder: View>: View {
    let url: URL?
    let placeholder: () -> Placeholder
    
    init(
        stringUrl: String,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = URL(string: stringUrl)
        self.placeholder = placeholder
    }
    
    init(stringUrl: String) where Placeholder == ProgressView<EmptyView, EmptyView> {
        self.url = URL(string: stringUrl)
        self.placeholder = { ProgressView() }
    }
    
    var body: some View {
        KFImage(url)
            .placeholder(placeholder)
            .fade(duration: 0.25)
            .resizable()
    }
}

#Preview {
    RemoteImageView(stringUrl: SubscriptionIdentifier.claudePro.imageUrlString)
        .scaledToFit()
        .frame(width: 100, height: 100)
}
