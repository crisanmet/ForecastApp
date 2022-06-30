//
//  WeatherService.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

protocol WeatherFetching{
    func fetchWeather(cityName: String, getLocation: Bool , lat: Double, long: Double, onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ())
}

struct WeatherService: WeatherFetching {
    
    static let shared = WeatherService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["APIKey"]!
    
    
    func fetchWeather(cityName: String, getLocation: Bool = false, lat: Double = 0.0, long: Double = 0.0,  onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ()) {
        
        let url = buildQueryString(cityName: cityName, getLocation: getLocation, lat: lat, long: long)
        
        APIManager.shared.get(url: url) { response in
            switch response {
            case .success(let data):
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(WeatherResponse.self, from: data)
                        onComplete(response)
                    }else {
                        onError(ApiError.noWeatherData.errorDescription!)
                    }
                } catch {
                    onError(ApiError.noWeatherData.errorDescription!)
                    debugPrint(error)
                }
            case .failure(_):
                onError(ApiError.noWeatherData.errorDescription!)
            }
        }
    }
    
    
    private func buildQueryString(cityName: String = "", getLocation: Bool = false, lat: Double = 0.0, long: Double = 0.0 ) -> String{
    
        let cityWithoutSpaces = cityName.replacingOccurrences(of: " ", with: "%20")
        var queryString = "\(baseURL)appid=\(apiKey)&units=metric&q=\(cityWithoutSpaces)"
        
        if getLocation {
            queryString = "\(baseURL)appid=\(apiKey)&units=metric&lat=\(lat)&lon=\(long)"
        }

        return queryString
       }
}
