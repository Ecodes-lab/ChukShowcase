//
//  CalendarCodeView.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 10/01/2025.
//

import SwiftUI

struct CalendarCodeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    implementationSection
                    usageSection
                }
                .padding()
            }
            .navigationTitle("Implementation")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var implementationSection: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Calendar Helper Implementation")
                    .font(.headline)
                
                CodeBlockView(code: """
                import Foundation

                struct CalendarHelper {
                    static let calendar = Calendar.current
                    
                    // MARK: - Calendar Functions
                    
                    // Check if a given date is in the future
                    static func isFutureDate(_ date: Date) -> Bool {
                        let currentDate = Date() // Get current date
                        return date > currentDate // Return true if the given date is later than the current date
                    }
                    
                    // Check if two dates fall on the same day
                    static func isSameDay(date1: Date, date2: Date) -> Bool {
                        return calendar.isDate(date1, inSameDayAs: date2) // Use calendar method to compare the days
                    }
                    
                    // Check if a given date is today
                    static func isDateToday(_ date: Date) -> Bool {
                        // Get components of the current date
                        let todayComponents = calendar.dateComponents([.year, .month, .day], from: Date())
                        // Get components of the given date
                        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
                        
                        // Compare the components to determine if the date is today
                        return dateComponents.year == todayComponents.year &&
                        dateComponents.month == todayComponents.month &&
                        dateComponents.day == todayComponents.day
                    }
                    
                    // Extract date components as strings
                    static func extractDate(for date: Date, isShortName: Bool = false) -> [String] {
                        let formatter = DateFormatter()
                        // Set date format based on whether short name is needed
                        formatter.dateFormat = "YYYY EEEE dd \\(isShortName ? "MMM" : "MMMM")"
                        let dateString = formatter.string(from: date) // Format date to string
                        return dateString.components(separatedBy: " ") // Split string into components
                    }
                    
                    // Get a date by adding a number of months to the current date
                    static func getMonth(_ month: Int) -> Date {
                        guard let date = calendar.date(byAdding: .month, value: month, to: Date()) else {
                            return Date() // Return current date if calculation fails
                        }
                        return date // Return the calculated date
                    }
                    
                    // Get a date by adding a number of years to the current date
                    static func getYearDate(_ year: Int) -> Date {
                        guard let date = calendar.date(byAdding: .year, value: year, to: Date()) else {
                            return Date() // Return current date if calculation fails
                        }
                        return date // Return the calculated date
                    }
                    
                    // Get the current year
                    static func getCurrentYear() -> Int {
                        return calendar.component(.year, from: Date()) // Extract year component from the current date
                    }
                    
                    // Get the difference in years between a given date and the current date
                    static func getYearDifference(from date: Date) -> Int {
                        let baseYear = getCurrentYear() // Get the current year
                        let yearComponent = calendar.component(.year, from: date) // Extract year component from the given date
                        return yearComponent - baseYear // Calculate the difference
                    }
                    
                    // Create date values for a given date
                    private static func createDateValues(for date: Date) -> [DateValue] {
                        let currentMonth = date // Set the current month to the given date
                        // Get all dates in the month and map them to DateValue objects
                        return currentMonth.getAllDates().compactMap { date -> DateValue in
                            let day = calendar.component(.day, from: date) // Get the day component
                            return DateValue(day: day, date: date) // Create DateValue object
                        }
                    }
                    
                    // Add leading empty days to the start of the month
                    private static func addLeadingEmptyDays(_ days: inout [DateValue]) {
                        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date()) // Get the weekday of the first date
                        // Insert empty DateValue objects for days before the first weekday
                        for _ in 0..<(firstWeekday - 1) {
                            days.insert(DateValue(day: -1, date: Date()), at: 0)
                        }
                    }
                    
                    // Extract date values for a given date
                    static func extractDates(for date: Date) -> [DateValue] {
                        var days = createDateValues(for: date) // Create date values for the given date
                        addLeadingEmptyDays(&days) // Add leading empty days
                        return days // Return the modified date values
                    }
                }
                """)
            }
            
            VStack {
                Text("Calendar ViewModel Implementation")
                    .font(.headline)
                
                CodeBlockView(code: """
                @Observable
                class CalendarViewModel {
                    var currentDate: Date = Date()
                    
                    var selectedYear = ""
                    
                    var selectedDates: [DateValue] = [DateValue]()
                    
                    var currentMonth: Int = 0
                    
                    var isSelectedDate: Bool = false
                    
                    var isFuture: Bool =  false
                    
                    // Function to check if two dates are on the same day
                    func isSameDay(date1: Date, date2: Date) -> Bool {
                        return CalendarHelper.isSameDay(date1: date1, date2: date2)
                    }
                    
                    func isDateToday(_ date: Date) -> Bool {
                        return CalendarHelper.isDateToday(date)
                    }
                    
                    func isFutureDate(_ date: Date) -> Bool {
                        return CalendarHelper.isFutureDate(date)
                    }
                    
                    func getCurrentMonth() -> Date {
                        if currentMonth > 0 {
                            isFuture = true
                        }
                        return CalendarHelper.getMonth(currentMonth)
                    }
                    
                    func extractDates() -> [DateValue] {
                        let currentMonthDate = getCurrentMonth()
                        return CalendarHelper.extractDates(for: currentMonthDate)
                    }
                    
                    func extractDate() -> [String] {
                        return CalendarHelper.extractDate(for: currentDate)
                    }
                }
                """)
            }
        }
    }
    
    private var usageSection: some View {
        VStack(alignment: .leading) {
            Text("Usage in SwiftUI")
                .font(.headline)
            
            CodeBlockView(code: """
            struct CalendarView: View {                                
                var viewModel = CalendarViewModel()
                            
                var body: some View {
                    ZStack(alignment: .topLeading) {
                        GeometryReader { geo in
                            VStack(spacing: 20) {
                                VStack {
                                    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                                    
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
                                                                
                                                                Text("\\(today), \\(viewModel.extractDate()[2]) \\(viewModel.extractDate()[3])")
                                                                    .font(.headline)
                                                                    .foregroundColor(ColorManager.primary)
                                                            } else {
                                                                Text("\\(viewModel.extractDate()[3])")
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
                                                            ForEach(days, id: \\.self) { day in
                                                                
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
                            }
                            .padding(.vertical)
                        }
                    }
                }
                
                @ViewBuilder
                func DateCell(value: DateValue) -> some View {
                    VStack {
                        if value.day != -1 {
                            Text("\\(value.day)")
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
            """)
        }
    }
}
