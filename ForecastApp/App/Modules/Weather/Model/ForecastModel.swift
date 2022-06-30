//
//  ForecastModel.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 28/06/2022.
//

import Foundation

struct ForecastModel {
    let time: Int
    let text: String
    let icon: String
    let temperature: Double
    
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
    
    var timeString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    var temperatureString: String{
        return String(format: "%.0f", temperature)
    }
    
}
