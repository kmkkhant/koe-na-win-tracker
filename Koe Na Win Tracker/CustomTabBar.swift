//
//  CustomTabBar.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case calendar = "calendar"
    case timer = "calendar.day.timeline.left"
    case chart = "chart.bar"
    case person = "person"
}


struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue){tab in
                    Spacer()
                    Image(systemName:  tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .onTapGesture{
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(10)
            .padding()
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.calendar))
}
