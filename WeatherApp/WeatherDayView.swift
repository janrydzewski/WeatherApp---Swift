//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI


struct CurrentWeather: Codable {
    let time: String
    let temperature2m: Double
    let isDay: Int
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case isDay = "is_day"
    }
}


struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let daily: DailyData
    let current: CurrentWeather
}

struct DailyData: Codable {
    let time: [String]
    let weatherCode: [Int]
    let temperature2mMax: [Double]
    let temperature2mMin: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case weatherCode = "weather_code"
        case temperature2mMax = "temperature_2m_max"
        case temperature2mMin = "temperature_2m_min"
    }
}

class CityWeatherModel: ObservableObject {
    
    var city: String = ""
    
    @Published var weatherData: WeatherData?
    
    var url = ""
    
    init(city: String) {
        self.city = city
    }
    
    
    func fetchData() async {
        
        switch city {
        case "Cupertino":
            url = "https://api.open-meteo.com/v1/forecast?latitude=37.323&longitude=-122.0322&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min"
        case "Paris":
            url = "https://api.open-meteo.com/v1/forecast?latitude=48.8534&longitude=2.3488&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min"
        case "Canberra":
            url = "https://api.open-meteo.com/v1/forecast?latitude=-35.2835&longitude=149.1281&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min"
        default:
            url = "https://api.open-meteo.com/v1/forecast?latitude=37.323&longitude=-122.0322&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min"
        }
        
        guard let url = URL(string: url) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            weatherData = decodedData
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

