//
//  WeatherModel.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let maxTemp: Double
    let minTemp: Double
    let pressure: Int
    let humidity: Int
    let longitude: Double
    let latitude: Double
    
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var maxTemperatureString: String{
        return String(format: "%.1f", maxTemp)
    }
    
    var minTemperatureString: String{
        return String(format: "%.1f", minTemp)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...521:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
