//
//  WeatherService.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

protocol WeatherFetching{
    func fetchWeather(cityName: String, onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ()) 
}

struct WeatherService: WeatherFetching {
    
    static let shared = WeatherService()
    
    private let baseURL = ProcessInfo.processInfo.environment["baseURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["APIKey"]!
    
    
    func fetchWeather(cityName: String, onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ()) {
        
        let cityWithoutSpaces = cityName.replacingOccurrences(of: " ", with: "%20")
        let url = baseURL + buildQueryString(cityWithoutSpaces)
        
        print(url)
        
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
    
    
    private func buildQueryString(_ cityName: String) -> String{
        
        return "appid=\(apiKey)&units=metric&q=\(cityName)"
       }
    
}
