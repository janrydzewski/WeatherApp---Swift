//
//  CupertinoView.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI

struct CupertinoView: View {
    
    @State private var isNight = false

    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                            CityWeatherInfo(
                                city: "Cupertino, CA")
                            MainWeatherInfo(
                                image: isNight ? "moon.zzz.fill" : "cloud.sun.fill",
                                temperature: isNight ? 30 : 76)
                            HStack(spacing: 20) {
                                WeekDayInfo(weekDay: "TUE",
                                            image: "cloud.sun.fill",
                                            temperature: 70)
                                WeekDayInfo(weekDay: "TUE",
                                            image: "cloud.drizzle.fill",
                                            temperature: 60)
                                WeekDayInfo(weekDay: "TUE",
                                            image: "wind",
                                            temperature: 45)
                                WeekDayInfo(weekDay: "TUE",
                                            image: "cloud.bolt.fill",
                                            temperature: 30)
                                WeekDayInfo(weekDay: "TUE",
                                            image: "cloud.snow.fill",
                                            temperature: 25)
                            }
                                .frame(height: 180)
                            Button {
                                isNight.toggle()
                            } label : {
                                WeatherButton(title: isNight ? "Change to day" : "Change to night", foregroundColor: .blue, backgroundColor: .white)
                            }
                            Spacer()
                        }.padding()
        }
        }
        
}
