//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import UIKit
import Lottie
import MapKit

class WeatherViewController: UIViewController {

    //MARK: - Properties
    
    lazy var viewModel: WeatherViewModel = {
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.delegate = self
        return weatherViewModel
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(WeatherViewController.locationPressed(_:)), for: .touchUpInside)
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
    
    private var weatherDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var maxTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var minTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var humidityIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "humidity.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.setDimensions(height: 30, width: 30)
        return image
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var windIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "wind")?.withTintColor(.green, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.setDimensions(height: 30, width: 30)
        return image
    }()
    
    private var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var pressureIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "thermometer")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        image.setDimensions(height: 30, width: 30)
        return image
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    lazy var collectionViewHour: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .white
            //collectionView.isPagingEnabled = true
            return collectionView
        }()
    
    //MARK: - mapkit
    
    private var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    let locationManager = CLLocationManager()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel.getWeatherData(cityName: "Buenos Aires")

        view.backgroundColor = .white
        setupConfigurationServices()
        setupView()
        
    }
    
    private func setupConfigurationServices(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func setupView(){
        
        //view.backgroundColor = .systemBlue
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
        
        let stackMaxAndMinTemperature = UIStackView(arrangedSubviews: [maxTemperature, minTemperature])
        stackMaxAndMinTemperature.axis = .horizontal
        stackMaxAndMinTemperature.spacing = 2
        
        let stackWeatherDescription = UIStackView(arrangedSubviews: [stackTemperature, weatherDescription, stackMaxAndMinTemperature])
        stackWeatherDescription.axis = .vertical
        stackWeatherDescription.spacing = 2
        
        let stackIconAndTemperature = UIStackView(arrangedSubviews: [animationIcon, stackWeatherDescription])
        stackIconAndTemperature.axis = .horizontal
        stackIconAndTemperature.spacing = 2
        stackIconAndTemperature.alignment = .leading
        animationIcon.setDimensions(height: 120, width: 120)
        view.addSubview(stackIconAndTemperature)
        stackIconAndTemperature.anchor(top: cityName.bottomAnchor)
        stackIconAndTemperature.centerX(inView: view)
        
        let stackHumidity = UIStackView(arrangedSubviews: [humidityIcon, humidityLabel])
        stackHumidity.axis = .vertical
        stackHumidity.spacing = 2
        stackHumidity.alignment = .center
        stackHumidity.setDimensions(height: 80, width: 100)
        stackHumidity.backgroundColor = .lightGray
        
        let stackWind = UIStackView(arrangedSubviews: [windIcon, windLabel])
        stackWind.axis = .vertical
        stackWind.spacing = 2
        stackWind.setDimensions(height: 80, width: 100)
        stackWind.alignment = .center
        stackWind.backgroundColor = .lightGray
        
        
        let stackPressure = UIStackView(arrangedSubviews: [pressureIcon, pressureLabel])
        stackPressure.axis = .vertical
        stackPressure.spacing = 2
        stackPressure.setDimensions(height: 80, width: 100)
        stackPressure.alignment = .center
        stackPressure.backgroundColor = .lightGray
        
        let stackHumidityWindPressure = UIStackView(arrangedSubviews: [stackHumidity, stackWind, stackPressure])
        stackHumidityWindPressure.axis = .horizontal
        stackHumidityWindPressure.spacing = 50
        stackHumidityWindPressure.alignment = .leading
        view.addSubview(stackHumidityWindPressure)
        stackHumidityWindPressure.anchor(top: stackIconAndTemperature.bottomAnchor, paddingTop: 10)
        stackHumidityWindPressure.centerX(inView: view)
        
        view.addSubview(collectionViewHour)
        collectionViewHour.anchor(top: stackHumidity.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor , paddingTop: 20)
        collectionViewHour.setHeight(150)

        
        view.addSubview(mapView)
        mapView.anchor(top: collectionViewHour.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor , paddingTop: 20)
        mapView.setHeight(200)
        
    }
   
    //MARK: - Helpers
    
    @objc func locationPressed(_ sender: UIButton){
        locationManager.requestLocation()
    }

}


//MARK: - Weather Delegates

extension WeatherViewController: WeatherViewModelDelegate {
    func didGetWeatherData(weather: WeatherModel) {
        DispatchQueue.main.async { [weak self] in
            self?.cityName.text = weather.cityName
            self?.temperatureString.text = weather.temperatureString
            self?.weatherDescription.text = weather.description.capitalized
            self?.maxTemperature.text = "H:\(weather.maxTemperatureString)°"
            self?.minTemperature.text = "L:\(weather.minTemperatureString)°"
            self?.humidityLabel.text = "\(weather.humidity)%"
            self?.windLabel.text = "\(weather.windSpeedString) Km/h"
            self?.pressureLabel.text = "\(weather.pressure) hPa"
            self?.animationIcon.animation = Animation.named(weather.lottieAnimation)
            self?.animationIcon.loopMode = .loop
            self?.animationIcon.play()
            self?.renderLocation(latitude: weather.latitude, longitude: weather.longitude, cityName: weather.cityName)
        }
    }
    func didFailGettingWeatherData(error: String) {
        print(error)
    }
    
    func didGetForecastData() {
        collectionViewHour.reloadData()
    }
}

//MARK: - Delegate TextField

extension WeatherViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else {return}
        
        viewModel.getWeatherData(cityname: city)
        viewModel.getForecastData(cityName: city)
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

//MARK: - Collection Delegate

extension WeatherViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getForecastCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath) as? HourlyWeatherCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configureCell(with: viewModel.getForecastSection(at: indexPath.row))

        return cell
    }
}


//MARK: - Mapkit

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("error:: \(error.localizedDescription)")
     }

     func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
         if status == .authorizedWhenInUse {
             locationManager.requestLocation()
         }
     }

     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

         if let location = locations.first {
             manager.stopUpdatingLocation()
             
             viewModel.getWeatherData(lat: location.coordinate.latitude, long: location.coordinate.latitude, getLocation: true)
             renderLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
         }

     }
    
    func renderLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, cityName: String = "") {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.title = cityName
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    
}
