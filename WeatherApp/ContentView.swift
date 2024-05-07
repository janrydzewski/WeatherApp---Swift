//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            CityView(city: "Cupertino")
            CityView(city: "Paris")
            CityView(city: "Canberra")
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}



#Preview {
    ContentView()
}
