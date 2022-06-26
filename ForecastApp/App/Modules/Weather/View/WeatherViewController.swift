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
    
    private var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let spacer = UIView()
        spacer.setDimensions(height: 40, width: 12)
        
        let textField = UITextField()
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.placeholder = "Search city..."
        textField.delegate = self
        textField.setHeight(40)
        return textField
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.text = "Buenos Aires"
        return label
     }()
    
    private var temperatureString: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.text = "21"
        return label
    }()
    
    private var celsiusString: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.text = "°C"
        return label
    }()
    
    private var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "sun.max")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return image
    }()
    

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupView()
    }
    

    private func setupView(){
        [cityName,weatherIcon].forEach{view.addSubview($0)}
        
        let stack = UIStackView(arrangedSubviews: [locationButton,searchTextField, searchButton])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        cityName.anchor(top: stack.bottomAnchor, paddingTop: 20)
        cityName.centerX(inView: view)
        
        weatherIcon.anchor(top: cityName.bottomAnchor)
        weatherIcon.setDimensions(height: 120, width: 120)
        weatherIcon.centerX(inView: view)
        
        let stackTemperature = UIStackView(arrangedSubviews: [temperatureString, celsiusString])
        stackTemperature.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        view.addSubview(stackTemperature)
        stackTemperature.anchor(top: weatherIcon.bottomAnchor)
        stackTemperature.centerX(inView: view)
        
        
    }
   

}


//MARK: - Weather Delegates

extension WeatherViewController: WeatherViewModelDelegate {
    func didGetWeatherData(weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.cityName.text = weather.cityName
            self?.temperatureString.text = weather.temperatureString
            self?.weatherIcon.image = UIImage(systemName: weather.conditionName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
    func didFailGettingWeatherData(error: String) {
        print(error)
    }
}

extension WeatherViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else {return}
        
        viewModel.getWeatherData(cityName: city)
        searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Enter a city name..."
            return false
        }
    }
    
}
