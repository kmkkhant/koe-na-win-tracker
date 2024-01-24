//
//  ContentView.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .timer
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $selectedTab) {
                
                TodayView()
                    .tabItem {
                        Label("Today", systemImage: Tab.timer.rawValue)
                    }
                    .tag(Tab.timer)
                
                MenuView()
                    .tabItem {
                        Label("Menu", systemImage: Tab.chart.rawValue)
                    }
                    .tag(Tab.chart)
                SignInView()
                    .tabItem {
                        Label("Sign In", systemImage: Tab.person.rawValue)
                    }
                    .tag(Tab.person)
            }
            .navigationBarTitleDisplayMode(.inline) // Optional for compact title display
                        .navigationBarHidden(true)
        }
        
        ZStack {
            
            VStack{
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
            }
            
        }
        
    }
}
#Preview {
    ContentView()
}
