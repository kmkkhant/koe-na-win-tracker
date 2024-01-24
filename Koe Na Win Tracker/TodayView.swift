//
//  TodayView.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI
import Foundation

let csvPath = "/Users/kaungminkhant/Desktop/projects/Koe Na Win Tracker/KoeNaWin.csv"

struct TodayView: View {
    @StateObject var taskModel: TaskViewModel = TaskViewModel()
    @Namespace var animation
    @State private var selectedDate = Date()
    @Environment(\.colorScheme) var colorScheme
    @State private var isDatePickerVisible = false
    
    var body: some View {
        
        ZStack{
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]){
                Section {
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 10) {
                            ForEach(taskModel.currentWeek, id: \.self){day in
                                VStack(spacing: 10){
                                    
                                    Text(taskModel.extractDate(date: day, format: "dd"))
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                    Text(taskModel.extractDate(date: day, format: "EEE"))
                                        .font(.system(size: 14))
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(taskModel.isToday(date: day) ? 1 : 0 )
                                }
                                .foregroundStyle(taskModel.isToday(date: day) ? .primary : .tertiary)
                                .foregroundColor(taskModel.isToday(date: day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack{
                                        if taskModel.isToday(date: day){
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDAY", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation{
                                        taskModel.currentDay = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                } header: {
                    HeaderView()
                }
            } //LazyVSTack end
        } //ScrollView End
        
    } //ZStack End
        .overlay(
            Group{
                ZStack {
                    if isDatePickerVisible {
                        Color.black.opacity(0.4).ignoresSafeArea()
                            .onTapGesture {
                                isDatePickerVisible = false
                            }
                        VStack {
                            Spacer()
                            DatePicker(
                                "Select a date",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                                
                            )
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                            .frame(maxWidth: .infinity)
                            
                            HStack {
                                Spacer()
                                Button("Done") {
                                    // Perform actions upon tapping the "Done" button
                                    taskModel.updateCurrentWeek(from: selectedDate)
                                    isDatePickerVisible = false // Dismiss the DatePicker
                                    // Additional actions, if any
                                }
                                .padding()
                                
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.clear)
                        .padding()
                    }
                }
            }
            )
        .onChange(of: isDatePickerVisible, initial: isDatePickerVisible) { (previousValue, newValue) in
            if newValue {
                selectedDate = taskModel.currentDay // Set selected date to current day
            }
        }

        .popover(isPresented: $taskModel.showDatePicker, content: {
                    Button(action: {
                        isDatePickerVisible = true // Show the custom date picker
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(14)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .padding(.trailing, 16)
                            .padding(.top, 16)
                    }
                })
    }
    func HeaderView()->some View {
        HStack (spacing: 10){
            VStack(alignment: .leading, spacing: 10){
                Text(Date().formatted(date: .long, time: .omitted))
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
                
            }
            .hLeading()
            
            Button {
                isDatePickerVisible = true
                
            } label: {
                Image(systemName: "calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(14)
                    .background(Color.customBlue)
                    .foregroundColor(.white)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, 16)
                    .padding(.top, 16)
            }
            
            
        }
        .padding()
        
        
    }
}

#Preview {
    TodayView()
}

extension View{
    func hLeading()-> some View {
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    func hTrailing()-> some View {
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
    }
    func hCenter()-> some View {
        self.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
    }
}
extension Color {
    static let customBlue = Color(hex: 0x31ABBC)
    
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
