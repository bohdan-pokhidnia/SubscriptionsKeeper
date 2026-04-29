//
//  NewSubscriptionView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 22.04.2026.
//

import SwiftUI

struct NewSubscriptionView: View {
    @Bindable var viewModel: NewSubscriptionViewModel

    var body: some View {
        Form {
            subscriptionView

            Section {
                TextField("Service name", text: $viewModel.subscription.name)
                TextField("Premium, Family, Pro", text: $viewModel.subscription.description)
            } header: {
                Text("Service")
            }
            
            Section {
                TextField("Cost", text: $viewModel.cost)
                    .keyboardType(.decimalPad)
                
                Picker("Subscription Currency", selection: $viewModel.subscription.currency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Text("\(currency.name) (\(currency.abbreviation))")
                            .tag(currency)
                    }
                }
                
                Picker("Payment cycle", selection: $viewModel.subscription.paymentCycle) {
                    ForEach(PaymentCycle.allCases, id: \.self) { paymentCycle in
                        Text(paymentCycle.displayName)
                            .tag(paymentCycle)
                    }
                }

                DatePicker(
                    "First payment",
                    selection: $viewModel.subscription.firstPaymentAt,
                    displayedComponents: .date
                )
            } header: {
                Text("Billing")
            }
        }
        .navigationTitle(viewModel.title)
        .toolbar {
            if viewModel.mode == .edit {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        viewModel.cancelButtonTapped()
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    viewModel.saveButtonTapped()
                }
            }
        }
    }

    private var subscriptionView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: viewModel.subscription.identifier.gradientColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    RemoteImageView(stringUrl: viewModel.subscription.identifier.imageUrlString)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Spacer()

                    Text(viewModel.subscription.cost.formatted(.price(currency: viewModel.subscription.currency)))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.subscription.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text(viewModel.subscription.paymentCycle.displayName)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .padding([.top, .horizontal], 24)
            .padding(.bottom, 16)
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
}

#Preview {
    NavigationStack {
        NewSubscriptionView(
            viewModel: NewSubscriptionViewModel(
                repository: try! SubscriptionsRepositoryImpl(),
                router: AppRouter(),
                subscription: Subscription(
                    id: UUID(),
                    identifier: .chatGPTPlus,
                    group: .ai,
                    name: "ChatGPT Plus",
                    description: "",
                    cost: 20,
                    currency: .usd
                ),
                mode: .edit
            )
        )
    }
}
