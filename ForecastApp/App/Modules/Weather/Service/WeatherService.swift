//
//  WeatherService.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

protocol WeatherFetching{
    func fetchWeather(onComplete: @escaping (WeatherResponse) ->(), onError: @escaping (String) ->(), cityName: String)
}

struct WeatherService: WeatherFetching {
    
    static let shared = WeatherService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["APIKey"]!
    
    
    func fetchWeather(onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> (), cityName: String) {
        
        let url = baseURL + buildQueryString(cityName)
        
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
                }
            case .failure(_):
                onError(ApiError.noWeatherData.errorDescription!)
            }
        }
    }
    
    
    private func buildQueryString(_ cityName: String) -> String{
        
        return "appid=\(apiKey)&units=metric&q=\(cityName)"
       }
    
}
