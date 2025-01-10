//
//  CalendarView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 10/01/2025.
//

import SwiftUI

struct CalendarView: View {
    @Environment(Coordinator.self) private var coordinator
    
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    
    var viewModel = CalendarViewModel()
    
    @State private var showingCode = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                
                GeometryReader { geo in
                    VStack(spacing: 20) {
                        VStack {
                            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                            
                            HStack {
                                
                                Text(viewModel.extractDate()[0])
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(ColorManager.primary)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            ZStack {
                                VStack(alignment: .leading) {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        VStack(alignment: .leading, spacing: 10) {
                                            HStack {
                                                
                                                Button {
                                                    withAnimation {
                                                        viewModel.currentDate = viewModel.getCurrentMonth()
                                                        viewModel.currentMonth -= 1
                                                    }
                                                } label: {
                                                    Image(systemName: "chevron.left")
                                                        .font(.title2)
                                                        .foregroundColor(ColorManager.primary)
                                                }
                                                Spacer(minLength: 0)
                                                
                                                HStack {
                                                    
                                                    if viewModel.isSelectedDate {
                                                        let today = viewModel.isDateToday(viewModel.currentDate) ? "Today" : viewModel.extractDate()[1]
                                                        
                                                        Text("\(today), \(viewModel.extractDate()[2]) \(viewModel.extractDate()[3])")
                                                            .font(.headline)
                                                            .foregroundColor(ColorManager.primary)
                                                    } else {
                                                        Text("\(viewModel.extractDate()[3])")
                                                            .font(.headline)
                                                            .foregroundColor(ColorManager.primary)
                                                    }
                                                }
                                                
                                                Spacer(minLength: 0)
                                                
                                                Button {
                                                    withAnimation {
                                                        viewModel.currentDate = viewModel.getCurrentMonth()
                                                        viewModel.currentMonth += 1
                                                    }
                                                } label: {
                                                    Image(systemName: "chevron.right")
                                                        .font(.title2)
                                                        .foregroundColor(ColorManager.primary)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                        
                                        VStack(spacing: 15) {
                                            VStack {
                                                HStack(spacing: 0) {
                                                    ForEach(days, id: \.self) { day in
                                                        
                                                        Text(day)
                                                            .font(.callout)
                                                            .fontWeight(.semibold)
                                                            .frame(maxWidth: .infinity)
                                                            .foregroundColor(ColorManager.primary)
                                                            .padding(.vertical, 20)
                                                            .border(ColorManager.accentGradient.opacity(0.8), width: 1)
                                                        
                                                    }
                                                }
                                                .background(ColorManager.accentGradient)
                                                
                                                // Dates
                                                let columns = Array(repeating: GridItem(.flexible()), count: 7)
                                                LazyVGrid(columns: columns, spacing: 8) {
                                                    ForEach(viewModel.selectedDates) { value in
                                                        DateCell(value: value)
                                                            .background(
                                                                Rectangle()
                                                                    .fill(ColorManager.accentGradient)
                                                                    .opacity(viewModel.isSelectedDate ?
                                                                             viewModel.isSameDay(date1: value.date, date2: viewModel.currentDate) ? 1 : 0 : 0)
                                                            )
                                                            .cornerRadius(10)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .stroke(ColorManager.accentGradient, lineWidth: 1)
                                                            )
                                                            .onTapGesture {
                                                                viewModel.currentDate = value.date
                                                                viewModel.isSelectedDate = true
                                                            }
                                                    }
                                                }
                                                .padding(.bottom, 1)
                                                .padding(.horizontal, 1)
                                            }
                                            .cornerRadius(10)
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                            }
                        }
                        
                        .onAppear {
                            withAnimation {
                                viewModel.selectedDates = viewModel.extractDates()
                            }
                        }
                        .onChange(of: viewModel.currentMonth) { _, newValue in
                            
                            withAnimation {
                                viewModel.selectedDates = viewModel.extractDates()
                            }
                            
                            viewModel.currentDate = viewModel.getCurrentMonth()
                            
                            viewModel.isSelectedDate = false
                            
                            if let _ = viewModel.extractDates().first(where: { value in
                                viewModel.isFutureDate(value.date) && viewModel.isSameDay(date1: value.date, date2: viewModel.currentDate)
                            }) {
                                viewModel.isFuture = true
                            } else {
                                viewModel.isFuture = false
                            }
                        }
                        
                        // Show Code Button
                        Button("Show Implementation") {
                            showingCode.toggle()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.vertical)
                    
                    
                }
            }
            .navigationTitle("Custom Calendar Demo")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingCode) {
                CalendarCodeView()
            }
        }
    }
    
    @ViewBuilder
    func DateCell(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
                    .foregroundColor(viewModel.isSelectedDate ?
                                     viewModel.isSameDay(date1: value.date, date2: viewModel.currentDate) ? .white : ColorManager.secondary
                                     : ColorManager.secondary)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
        .gesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onEnded { gesture in
                    // Determine the swipe direction
                    let translation = gesture.translation.width
                    
                    if translation > 0 {
                        withAnimation {
                            viewModel.currentDate = viewModel.getCurrentMonth()
                            viewModel.currentMonth -= 1
                        }
                        
                    }
                    
                    if translation < 0 {
                        withAnimation {
                            viewModel.currentDate = viewModel.getCurrentMonth()
                            viewModel.currentMonth += 1
                        }
                    }
                }
        )
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
