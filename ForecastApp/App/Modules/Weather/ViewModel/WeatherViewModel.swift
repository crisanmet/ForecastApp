//
//  WeatherViewModel.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func didGetWeatherData(weather: WeatherModel)
    func didFailGettingWeatherData(error: String)
}

class WeatherViewModel{
    
    weak var delegate: WeatherViewModelDelegate?
    
    var weatherService: WeatherFetching
    
    init(weatherService: WeatherFetching = WeatherService()){
        self.weatherService = weatherService
    }
    
    func getWeatherData(cityName: String){
        DispatchQueue.global().async { [weak self] in
            self?.weatherService.fetchWeather(onComplete: { weather in
                self?.getWeatherModel(weather)
            }, onError: { error in
                print(error)
                self?.delegate?.didFailGettingWeatherData(error: error)
            }, cityName: "london")
        }
    }
    
    func getWeatherModel(_ weather: WeatherResponse){
        let weather = WeatherModel(conditionId: weather.id, cityName: weather.name, temperature: weather.main.temp, maxTemp: weather.main.tempMax, minTemp: weather.main.tempMin, pressure: weather.main.pressure, humidity: weather.main.humidity, longitude: weather.coord.lon, latitude: weather.coord.lat)
        
        self.delegate?.didGetWeatherData(weather: weather)
    }
}
