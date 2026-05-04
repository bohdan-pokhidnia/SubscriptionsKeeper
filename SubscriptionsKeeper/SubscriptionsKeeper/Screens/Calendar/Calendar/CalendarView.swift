//
//  CalendarView.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 04.05.2026.
//

import SwiftUI

struct CalendarView: View {
    @Bindable var viewModel: CalendarViewModel
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                remainingView
                
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var remainingView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        stops: [
                            .init(color: Color(red: 0.82, green: 0.22, blue: 0.88), location: 0.0),
                            .init(color: Color(red: 0.94, green: 0.42, blue: 0.63), location: 0.5),
                            .init(color: Color(red: 0.90, green: 0.56, blue: 0.20), location: 1.0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 8, y: 4)

            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("REMAINING")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text(viewModel.remainingCost.formatted(.price(currency: viewModel.currency)))
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(viewModel.paymentsCount) payments this month")
                        .font(.subheadline)
                }

                Spacer()

                VStack(spacing: 0) {
                    if let nextChargeDate = viewModel.nextChargeDate {
                        VStack(spacing: 4) {
                            Text("Next charge")
                                .font(.caption)
                            
                            Text(nextChargeDate, format: .dateTime.day().month(.abbreviated))
                                .font(.title3)
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(.white.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .padding(16)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    NavigationStack {
        CalendarView(viewModel: CalendarViewModel())
    }
}
