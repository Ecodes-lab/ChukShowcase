//
//  CalendarHelper.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 10/01/2025.
//

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
        formatter.dateFormat = "YYYY EEEE dd \(isShortName ? "MMM" : "MMMM")"
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
