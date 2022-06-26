//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import UIKit
import Lottie

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
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
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
    
    lazy var animationIcon: AnimationView = {
        let animation = AnimationView()
        return animation
    }()
    

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getWeatherData(cityName: "Buenos Aires")

        view.backgroundColor = .white
        setupView()
    }
    

    private func setupView(){
        [cityName].forEach{view.addSubview($0)}
        
        let stackSearchBar = UIStackView(arrangedSubviews: [locationButton,searchTextField, searchButton])
        stackSearchBar.axis = .horizontal
        stackSearchBar.spacing = 2
        stackSearchBar.alignment = .fill
        stackSearchBar.distribution = .fillProportionally
        view.addSubview(stackSearchBar)
        stackSearchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        cityName.anchor(top: stackSearchBar.bottomAnchor, paddingTop: 20)
        cityName.centerX(inView: view)
        
        
        let stackTemperature = UIStackView(arrangedSubviews: [temperatureString, celsiusString])
        stackTemperature.axis = .horizontal
        stackSearchBar.spacing = 2
        
        let stackIconAndTemperature = UIStackView(arrangedSubviews: [animationIcon, stackTemperature])
        stackIconAndTemperature.axis = .horizontal
        stackIconAndTemperature.spacing = 2
        stackIconAndTemperature.alignment = .center
        animationIcon.setDimensions(height: 120, width: 120)
        view.addSubview(stackIconAndTemperature)
        stackIconAndTemperature.anchor(top: cityName.bottomAnchor)
        stackIconAndTemperature.centerX(inView: view)
    }
   

}


//MARK: - Weather Delegates

extension WeatherViewController: WeatherViewModelDelegate {
    func didGetWeatherData(weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.cityName.text = weather.cityName
            self?.temperatureString.text = weather.temperatureString
            self?.weatherIcon.image = UIImage(systemName: weather.conditionName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
            self?.animationIcon.animation = Animation.named(weather.lottieAnimation)
            self?.animationIcon.loopMode = .loop
            self?.animationIcon.play()
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
