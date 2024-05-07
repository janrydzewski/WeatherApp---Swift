//
//  CupertinoView.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI

struct CityView: View {
    
    @State private var isNight = false
    
    var pickedCity: String
    
    @ObservedObject var vm: CityWeatherModel
    
    init(city: String) {
        self.pickedCity = city
        self.vm = CityWeatherModel(city: city)
    }
    
    func getImage(weatherCode: Int) -> String {
        switch weatherCode {
        case 0:
            return "sun.max.fill"
        case 1,2,3, 45, 48:
            return "cloud.sun.fill"
        case 51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82:
            return "cloud.rain.fill"
        case 71, 73, 75, 77, 85, 86:
            return "cloud.snow.fill"
        case 95, 96, 99:
            return "cloud.bolt.fill"
        default:
            return "sun.max.fill"
        }
    }
    
    func getDayOfWeekAbbreviation(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return dateFormatter.string(from: date)
    }
    
    
    var body: some View {
        ZStack {
            
            BackgroundView(isNight: isNight)
            VStack {
                if let weatherData = vm.weatherData {
                    CityWeatherInfo(
                        city: "\(pickedCity)")
                    MainWeatherInfo(
                        image: isNight ? "moon.zzz.fill" : getImage(weatherCode: weatherData.daily.weatherCode[0]),
                        temperature: isNight ? weatherData.daily.temperature2mMin[0] : weatherData.current.temperature2m)
                    HStack(spacing: 20) {
                        ForEach(weatherData.daily.time.indices.prefix(upTo: 5), id: \.self) {
                            index in WeekDayInfo(
                                weekDay: getDayOfWeekAbbreviation(from: weatherData.daily.time[index]) ?? "2024-05-07",
                                image: getImage(weatherCode: weatherData.daily.weatherCode[index]),
                                temperature: weatherData.daily.temperature2mMax[index])
                        }
                        
                    }
                    
                    .frame(height: 180)
                    Spacer()
                    Button {
                        isNight.toggle()
                    } label : {
                        WeatherButton(title: isNight ? "Change to day" : "Change to night", foregroundColor: .blue, backgroundColor: .white)
                    }
                    Spacer()
                    
                } else {
                    Text("Loading...")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundStyle(.white)
                        .onAppear {
                            Task {
                                await vm.fetchData()
                                
                            }
                        }
                }
                
                
            }
        }
        
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
    var temperature: Double
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 160)
            Text("\(String(format: "%.1f", temperature))°C")
                .frame(width: 250, height: 100)
                .font(.system(size: 70, weight: .bold, design: .default))
                .foregroundStyle(.white)
        }
        .padding()
    }
}

struct WeekDayInfo: View {
    
    var weekDay: String
    var image: String
    var temperature: Double
    
    var body: some View {
        VStack {
            Text(weekDay)
                .textCase(.uppercase)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            Text("\(String(format: "%.1f", temperature))°C")
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundStyle(.white)
        }
        
    }
}
