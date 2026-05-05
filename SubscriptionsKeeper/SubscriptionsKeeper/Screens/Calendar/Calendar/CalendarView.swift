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
        VStack(spacing: 16) {
            remainingView
            
            calendarView
        }
        .padding([.horizontal, .bottom], 16)
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension CalendarView {
    var remainingView: some View {
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
    
    var calendarView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
            
            VStack(spacing: 8) {
                calendarHeaderView
                
                calendarGridView
            }
            .padding(16)
        }
    }
    
    var calendarHeaderView: some View {
        HStack(spacing: 0) {
            Button {
                viewModel.goToPreviousMonth()
            } label: {
                Image(systemName: "chevron.left")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }

            Spacer()

            VStack(spacing: 4) {
                Text(viewModel.monthTitle)
                    .font(.title2)
                    .fontWeight(.bold)

                Text(viewModel.yearTitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                viewModel.goToNextMonth()
            } label: {
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
    }
    
    var calendarGridView: some View {
        let days = viewModel.daysInMonth
        let offset = viewModel.firstWeekdayOffset
        let totalSlots = offset + days.count
        let rows = (totalSlots + 6) / 7

        return Grid(alignment: .top, horizontalSpacing: 6, verticalSpacing: 8) {
            // Weekday headers
            GridRow {
                ForEach(viewModel.weekdaySymbols.indices, id: \.self) { index in
                    Text(viewModel.weekdaySymbols[index])
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Day rows
            ForEach(0..<rows, id: \.self) { row in
                GridRow {
                    ForEach(0..<7, id: \.self) { column in
                        let index = row * 7 + column
                        let dayNumber = index - offset + 1

                        if dayNumber >= 1 && dayNumber <= days.count {
                            calendarDayView(day: dayNumber)
                        } else {
                            Color.clear
                                .frame(maxWidth: .infinity, minHeight: 50)
                        }
                    }
                }
            }
        }
    }

    func calendarDayView(day: Int) -> some View {
        let isToday = viewModel.isToday(day: day)
        let daySubscriptions = viewModel.subscriptionsForDay(day)

        return VStack(spacing: 4) {
            Text(day.description)
                .font(.body)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 8)
                .padding(.top, 6)

            if let first = daySubscriptions.first {
                RemoteImageView(stringUrl: first.imageUrlString)
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isToday ? Color.purple.opacity(0.6) : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    NavigationStack {
        CalendarView(viewModel: CalendarViewModel())
    }
}
