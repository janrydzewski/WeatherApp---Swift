//
//  WeatherButton.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI

struct WeatherButton: View {
    
    var title: String
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(backgroundColor)
            .foregroundStyle(foregroundColor)
            .font(.system(size: 20, weight: .medium, design: .default))
            .clipShape(.rect(cornerRadius: 10))
            .padding()
    }
}
