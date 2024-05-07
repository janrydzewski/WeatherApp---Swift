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
            CupertinoView()
            CupertinoView()
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: 
                        Gradient(colors:
                                    isNight ? [.black, .white] : [.blue, Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityWeatherInfo: View {
    
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherInfo: View {
    
    var image: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 160)
            Text("\(temperature)°")
                .frame(width: 200, height: 100)
                .font(.system(size: 70, weight: .bold, design: .default))
                .foregroundStyle(.white)
        }
        .padding()
    }
}

struct WeekDayInfo: View {
    
    var weekDay: String
    var image: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(weekDay)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            Image(systemName: image)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundStyle(.white)
        }
        
    }
}

#Preview {
    ContentView()
}
