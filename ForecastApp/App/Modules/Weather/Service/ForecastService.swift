//
//  ForecastService.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 28/06/2022.
//

import Foundation

protocol ForecastFetching{
    func fetchWeatherHourData(cityName: String, onComplete: @escaping (ForecastResponse) -> (), onError: @escaping (String) -> ())
}

struct ForecastService: ForecastFetching{
    
    private let forecastURL = ProcessInfo.processInfo.environment["forecastURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["APIKey"]!
    
    func fetchWeatherHourData(cityName: String, onComplete: @escaping (ForecastResponse) -> (), onError: @escaping (String) -> ()){
        let url = buildForecastString(cityName: cityName)
        
        APIManager.shared.get(url: url) { response in
            switch response {
            case .success(let data):
                do {
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(ForecastResponse.self, from: data)
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
    
    private func buildForecastString(cityName: String) -> String{
        let cityWithoutSpaces = cityName.replacingOccurrences(of: " ", with: "%20")
        let queryString = "\(forecastURL)appid=\(apiKey)&units=metric&q=\(cityWithoutSpaces)"
        
        print(queryString)
        return queryString
    }
}
