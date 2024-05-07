//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Jan Rydzewski on 07/05/2024.
//

import SwiftUI


//struct DayWeather: Codable, Hashable {
//    let date: String
//    let temperatureMax: Double
//    let temperatureMin: Double
//    let weatherCode: Int
//    
//    enum CodingKeys: String, CodingKey {
//            case date = "time"
//            case weatherCode = "weather_code"
//            case temperatureMax = "temperature_2m_max"
//            case temperatureMin = "temperature_2m_min"
//        }
//
//}
//
//struct CityWeather: Codable {
//    let dailyWeather: [DayWeather]
//    
//    enum CodingKeys: String, CodingKey {
//            case dailyWeather = "daily"
//        }
//    
//}
//
//
//
//class CityWeatherModel: ObservableObject {
//    @Published var weatherData = [CityWeather]()
//    
//    func fetchData() async {
//            guard let fetchedWeather: [CityWeather] = await WebService().downloadData(fromURL: "https://api.open-meteo.com/v1/forecast?latitude=37.323&longitude=-122.0322&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min") else {return}
//        print(fetchedWeather);
//            weatherData = fetchedWeather
//        }
//}

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
    @Published var weatherData: WeatherData?
    
    func fetchData() async {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=37.323&longitude=-122.0322&current=temperature_2m,is_day&daily=weather_code,temperature_2m_max,temperature_2m_min") else { return }
        
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

