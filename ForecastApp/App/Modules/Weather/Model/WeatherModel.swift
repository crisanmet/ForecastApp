//
//  WeatherModel.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let icon: String
    let temperature: Double
    let maxTemp: Double
    let minTemp: Double
    let pressure: Int
    let humidity: Int
    let longitude: Double
    let latitude: Double
    let description: String
    
    
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
        switch icon {
          case "01d":
              return "sun.max.fill"
          case "01n":
              return "moon.fill"
          case "02d":
              return "cloud.sun.fill"
          case "02n":
              return "cloud.moon.fill"
          case "03d":
              return "cloud.fill"
          case "03n":
              return "cloud.fill"
          case "04d":
              return "cloud.fill"
          case "04n":
              return "cloud.fill"
          case "09d":
              return "cloud.drizzle.fill"
          case "09n":
              return "cloud.drizzle.fill"
          case "10d":
              return "cloud.heavyrain.fill"
          case "10n":
              return "cloud.heavyrain.fill"
          case "11d":
              return "cloud.bolt.fill"
          case "11n":
              return "cloud.bolt.fill"
          case "13d":
              return "cloud.snow.fill"
          case "13n":
              return "cloud.snow.fill"
          case "50d":
              return "cloud.fog.fill"
          case "50n":
              return "cloud.fog.fill"
          default:
              return "sun.max.fill"
          }
    }
}
