//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    //MARK: - Properties
    
    lazy var viewModel: WeatherViewModel = {
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.delegate = self
        return weatherViewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        viewModel.getWeatherData(cityName: "london")
    }
    

   

}


//MARK: - Weather Delegates

extension WeatherViewController: WeatherViewModelDelegate {
    func didGetWeatherData(weather: WeatherModel) {
        print(weather.temperature)
    }
    func didFailGettingWeatherData(error: String) {
        print(error)
    }
}
