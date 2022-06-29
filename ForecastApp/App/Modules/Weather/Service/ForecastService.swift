//
//  ForecastService.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 28/06/2022.
//

import Foundation

protocol ForecastFetching{
    func fetchWeatherHourData(cityName: String,getLocation: Bool, lat: Double, long: Double, onComplete: @escaping (ForecastResponse) -> (), onError: @escaping (String) -> ())
}

struct ForecastService: ForecastFetching{
    
    private let forecastURL = ProcessInfo.processInfo.environment["forecastURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["APIKey"]!
    
    func fetchWeatherHourData(cityName: String,getLocation: Bool = false, lat: Double = 0.0, long: Double = 0.0, onComplete: @escaping (ForecastResponse) -> (), onError: @escaping (String) -> ()){
        
        let url = buildForecastString(cityName: cityName, getLocation: getLocation, lat: lat, long: long)
        
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
    
    private func buildForecastString(cityName: String = "", getLocation: Bool = false, lat: Double = 0.0, long: Double = 0.0 ) -> String{
    
        let cityWithoutSpaces = cityName.replacingOccurrences(of: " ", with: "%20")
        var queryString = "\(forecastURL)appid=\(apiKey)&units=metric&q=\(cityWithoutSpaces)"
        
        if getLocation {
            queryString = "\(forecastURL)appid=\(apiKey)&units=metric&lat=\(lat)&lon=\(long)"
        }
        return queryString
       }
}
