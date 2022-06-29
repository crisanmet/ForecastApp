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
    func didGetForecastData()
}

protocol CityViewModelDelegate {
    func getWeatherData(cityName: String)
}

class WeatherViewModel{
    
    weak var delegate: WeatherViewModelDelegate?
    
    var forecastHourlyWeather = [ForecastModel]()
    
    var weatherService: WeatherFetching
    
    var forecastService: ForecastFetching
    
    init(weatherService: WeatherFetching = WeatherService(), forecastService: ForecastFetching = ForecastService()){
        self.weatherService = weatherService
        self.forecastService = forecastService
    }
    
    func getWeatherData(cityname: String = "", lat: Double = 0.0, long: Double = 0.0, getLocation: Bool = false){
        print("pasooooo")
        DispatchQueue.global().async { [ weak self] in
            self?.weatherService.fetchWeather(cityName: cityname, getLocation: getLocation, lat: lat, long: long, onComplete: { weather in
                print("pasado a model \(weather)")
                self?.getWeatherModel(weather)
            }, onError: { error in
                print("pasado a model \(error)")
                self?.delegate?.didFailGettingWeatherData(error: error)
            })
        }
    }
    
    func getForecastData(cityname: String = "", lat: Double = 0.0, long: Double = 0.0, getLocation: Bool = false){
        DispatchQueue.global().async { [weak self] in
            self?.forecastService.fetchWeatherHourData(cityName: cityname, getLocation: getLocation, lat: lat, long: long, onComplete: { forecast in
                self?.getForecastConditions(forecast)
            }, onError: { error in
                self?.delegate?.didFailGettingWeatherData(error: error)
            })
        }
    }
    
    private func getWeatherModel(_ weather: WeatherResponse){
        let weather = WeatherModel(conditionId: weather.id, cityName: weather.name,icon: weather.weather[0].icon, temperature: weather.main.temp, maxTemp: weather.main.tempMax, minTemp: weather.main.tempMin, pressure: weather.main.pressure, humidity: weather.main.humidity, longitude: weather.coord.lon, latitude: weather.coord.lat, description: weather.weather[0].weatherDescription, windSpeed: weather.wind.speed)
    
        print(weather)
        self.delegate?.didGetWeatherData(weather: weather)
    }
    
    private func getForecastConditions(_ weather: ForecastResponse){
        for i in 1 ..< 14 {
            forecastHourlyWeather.append(ForecastModel(time: weather.list[i].dt, text: weather.list[i].weather[0].main, icon: weather.list[i].weather[0].icon))
            
            self.delegate?.didGetForecastData()
        }
    }
    
    func getForecastCount() -> Int{
        return forecastHourlyWeather.count
    }
    
    func getForecastSection(at index:Int) -> ForecastModel{
        return forecastHourlyWeather[index]
    }
}
