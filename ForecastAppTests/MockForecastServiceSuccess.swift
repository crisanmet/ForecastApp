//
//  MockForecastServiceSuccess.swift
//  ForecastAppTests
//
//  Created by Cristian Sancricca on 30/06/2022.
//

import Foundation
@testable import ForecastApp

class MockForecastServiceSuccess: WeatherFetching {
    func fetchWeather(cityName: String, getLocation: Bool, lat: Double, long: Double, onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ()) {
        let url = Bundle.main.url(forResource: "Mock", withExtension: "json")
        do{
            let decoder = JSONDecoder()
            let jsonData = try Data(contentsOf: url!)
            let model = try decoder.decode(WeatherResponse.self, from: jsonData)
            onComplete(model)
        } catch{
            onError("")
        }
    }
    
    
    
}
