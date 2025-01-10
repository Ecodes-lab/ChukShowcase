//
//  Date+Ext.swift
//  ChukShowcase
//
//  Created by Eco Dev S-SSD  on 10/01/2025.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    
    // Function to get all dates of the month of the given date
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // Getting the first day of the month using the .dateComponents(_:from:) and .date(from:) methods
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        // Getting the range of days in the month using the .range(_:in:for:) method
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // Generating an array of all dates in the month by adding 'day - 1' number of days to the startDate
        return range.compactMap({ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        })
    }

}
