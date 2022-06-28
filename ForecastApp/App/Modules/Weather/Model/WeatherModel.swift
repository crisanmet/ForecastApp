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
    let windSpeed: Double
    
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var maxTemperatureString: String{
        return String(format: "%.0f", maxTemp)
    }
    
    var minTemperatureString: String{
        return String(format: "%.0f", minTemp)
    }
    
    var windSpeedString: String {
        return String(format: "%.1f", windSpeed)
    }
    
    var lottieAnimation: String {
        switch icon {
         case "01d":
             return "dayClearSky"
         case "01n":
             return "nightClearSky"
         case "02d":
             return "dayFewClouds"
         case "02n":
             return "nightFewClouds"
         case "03d":
             return "dayScatteredClouds"
         case "03n":
             return "nightScatteredClouds"
         case "04d":
             return "dayBrokenClouds"
         case "04n":
             return "nightBrokenClouds"
         case "09d":
             return "dayShowerRains"
         case "09n":
             return "nightShowerRains"
         case "10d":
             return "dayRain"
         case "10n":
             return "nightRain"
         case "11d":
             return "dayThunderstorm"
         case "11n":
             return "nightThunderstorm"
         case "13d":
             return "daySnow"
         case "13n":
             return "nightSnow"
         case "50d":
             return "dayClearSky"
         case "50n":
             return "dayClearSky"
         default:
             return "dayClearSky"
         }
    }
}
