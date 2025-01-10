//
//  CalendarViewModel.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 10/01/2025.
//

import SwiftUI

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
