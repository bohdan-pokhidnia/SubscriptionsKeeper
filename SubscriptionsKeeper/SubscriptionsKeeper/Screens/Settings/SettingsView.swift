//
//  SettingsView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 29.04.2026.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            ScrollView {
                ContentSectionView {
                    ContentFieldView(
                        icon: "banknote",
                        iconColor: .black,
                        label: "Main Currency"
                    ) {
                        Picker("Subscription Currency", selection: $viewModel.currency) {
                            ForEach(Currency.allCases, id: \.self) { currency in
                                Text("\(currency.name) (\(currency.abbreviation))")
                                    .tag(currency)
                            }
                        }
                        .tint(.secondary)
                    }
                    
                    ContentSectionDivider()
                    
                    ContentFieldView(
                        icon: "icloud.fill",
                        iconColor: .black,
                        label: "iCloud Sync"
                    ) {
                        Text("Active")
                            .foregroundStyle(.secondary)
                    }
                    
                    ContentSectionDivider()
                }
                .padding(16)
                
                ContentSectionView {
                    Button {
                        viewModel.privacyPolicyTapped()
                    } label: {
                        ContentFieldView(
                            icon: "hand.raised.fill",
                            iconColor: .blue,
                            label: "Privacy Policy",
                            labelColor: .blue
                        ) {
                            EmptyView()
                        }
                    }
                    
                    ContentSectionDivider()
                    
                    Button {
                        viewModel.termsOfUseTapped()
                    } label: {
                        ContentFieldView(
                            icon: "doc.text",
                            iconColor: .blue,
                            label: "Terms of Use",
                            labelColor: .blue
                        ) {
                            EmptyView()
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        viewModel.doneButtonTapped()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView(
            viewModel: SettingsViewModel(router: AppRouter())
        )
    }
}
