//
//  TaskViewModel.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI

class TaskViewModel: ObservableObject{
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    @Published var showDatePicker: Bool = false
    
    init(){
        fetchCurrentWeek()
    }
    
    func fetchCurrentWeek(){
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (1...81).forEach{day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay){
                currentWeek.append(weekday)
            }
        }
    }
    func updateCurrentWeek(from selectedDate: Date) {
            // Use the selected date to update the current week
            // Your logic to update the current week from the selected date
            // For example, modify the function fetchCurrentWeek to use the selected date
            // This function is just an example, replace it with your logic
            let calendar = Calendar.current
            var startDate = selectedDate

            let weekdayComponent = calendar.component(.weekday, from: startDate)
            let daysToSubtract = (weekdayComponent - calendar.firstWeekday + 7) % 7
            if daysToSubtract != 0 {
                startDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: startDate) ?? startDate
            }

            currentWeek.removeAll()

            (1..<82).forEach { day in
                if let nextDay = calendar.date(byAdding: .day, value: day, to: startDate) {
                    currentWeek.append(nextDay)
                }
            }
    }
    
    func extractDate(date: Date, format: String)->String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = format
        
        return formatter.string(from: date)
        
    }
    
    func isToday(date: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
}
