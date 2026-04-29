//
//  SubscriptionDetailsView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 27.04.2026.
//

import SwiftUI

struct SubscriptionDetailsView: View {
    @Bindable var viewModel: SubscriptionDetailsViewModel
    @State private var headerBackground: Color = Color(.systemGray5)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(headerBackground.opacity(0.14).gradient)

            ScrollView {
                VStack(spacing: 16) {
                    headerView

                    VStack(spacing: 12) {
                        statusSection
                        infoSection
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
        }
        .ignoresSafeArea()
        .alert("Delete \(viewModel.subscription.name)?", isPresented: $viewModel.showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            
            Button("Delete", role: .destructive) {
                viewModel.deleteConfirmed()
            }
        } message: {
            Text("This subscription will be permanently removed.")
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.closeButtonTapped()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .tint(.secondary)
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    viewModel.editButtonTapped()
                } label: {
                    Image(systemName: "pencil")
                }

                Button {
                    viewModel.removeButtonTapped()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }

    // MARK: - Subviews

    private var headerView: some View {
        VStack(spacing: 16) {
            RemoteImageView(stringUrl: viewModel.subscription.imageUrlString) { image in
                headerBackground = image.dominantColor()
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .black.opacity(0.08), radius: 8, y: 2)

            Text(viewModel.subscription.name)
                .font(.title.bold())
        }
        .padding(.top, 200)
        .padding(.bottom, 100)
    }

    private var statusSection: some View {
        ContentSectionView {
            ContentFieldView(
                icon: "checkmark.circle.fill",
                iconColor: viewModel.isActive ? .green : .gray,
                label: "Status"
            ) {
                Text(viewModel.isActive ? "Active" : "Inactive")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(viewModel.isActive ? .green : .secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(viewModel.isActive ? Color.green.opacity(0.15) : Color.secondary.opacity(0.15))
                    )
            }
        }
    }

    private var infoSection: some View {
        ContentSectionView {
            ContentFieldView(icon: "calendar", label: "Next payment") {
                Text(viewModel.nextPaymentDateFormatted)
                    .font(.subheadline.weight(.semibold))
            }

            ContentSectionDivider()

            ContentFieldView(icon: "arrow.clockwise", label: "Billing cycle") {
                Text(viewModel.subscription.paymentCycle.displayName)
                    .font(.subheadline.weight(.semibold))
            }

            ContentSectionDivider()

            ContentFieldView(icon: "creditcard", label: "Per payment") {
                Text(viewModel.perPaymentFormatted)
                    .font(.subheadline.weight(.semibold))
            }

            ContentSectionDivider()

            ContentFieldView(icon: "chart.line.uptrend.xyaxis", label: "Yearly cost") {
                Text(viewModel.yearlyCostFormatted)
                    .font(.subheadline.weight(.semibold))
            }
        }
    }
}

#Preview {
    NavigationStack {
        SubscriptionDetailsView(
            viewModel: SubscriptionDetailsViewModel(
                repository: try! SubscriptionsRepositoryImpl(),
                router: AppRouter(),
                subscription: .preview(identifier: .iCloudPlus, name: "iCloud+")
            )
        )
    }
}
