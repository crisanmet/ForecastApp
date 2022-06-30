//
//  ForecastResponse.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 28/06/2022.
//

import Foundation

// MARK: - WeatherForecastResponse
struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let country: String?
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let weather: [Weather]
    let main: Main
}



//// MARK: - Weather
//struct WeatherHour: Codable {
//    let id: Int
//    let main: MainEnum
//    let weatherDescription: Description
//    let icon: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, main
//        case weatherDescription = "description"
//        case icon
//    }
//}
//
//enum MainEnum: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case rain = "Rain"
//}
//
//enum Description: String, Codable {
//    case brokenClouds = "broken clouds"
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case overcastClouds = "overcast clouds"
//    case scatteredClouds = "scattered clouds"
//}
