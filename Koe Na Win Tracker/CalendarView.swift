//
//  CalendarView.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI
import HorizonCalendar

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            VStack{
                Text("hello")
            }
            .navigationTitle("Calendar")
            
        }
            
    }
    
    
}


#Preview {
    CalendarView()
}
