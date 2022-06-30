//
//  MockCharacterServiceFail.swift
//  ForecastAppTests
//
//  Created by Cristian Sancricca on 30/06/2022.
//

import Foundation
@testable import ForecastApp

class MockForecastServiceFail: WeatherFetching {
    func fetchWeather(cityName: String, getLocation: Bool, lat: Double, long: Double, onComplete: @escaping (WeatherResponse) -> (), onError: @escaping (String) -> ()) {
        onError(ApiError.noWeatherData.errorDescription!)
    }
}
