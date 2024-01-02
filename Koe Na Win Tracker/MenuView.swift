//
//  MenuView.swift
//  Koe Na Win Tracker
//
//  Created by Kaung Min Khant on 12/23/23.
//

import SwiftUI

struct LineShape: Shape {
    let from: CGPoint
    let to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: from)
            path.addLine(to: to)
        }
    }
}

struct VerticalLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct MenuView: View {
    
    var body: some View {
        NavigationView{
            
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 1), count: 3), spacing: 100) {
                ForEach(0..<9) { index in
                    
                    VStack(spacing: 0){
                        Circle()
                            //.fill(Color.customBlue) // Customize color and other properties as needed
                            .strokeBorder(Color.customBlue,lineWidth: 2.5)
                            .frame(width: 30, height: 30)
                        
                        Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 85.00588, height: 0)
                        .background(Color(red: 0.19, green: 0.67, blue: 0.74))
                        
                    }
                }
            }
            .padding()
            .navigationTitle("Progress")
        
        }
        
    }
}


#Preview {
    MenuView()
}
