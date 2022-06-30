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
    
    let userDefaults = UserDefaults.standard
    
    lazy var viewModel: WeatherViewModel = {
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.delegate = self
        return weatherViewModel
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(WeatherViewController.locationPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Search city...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
        textField.delegate = self
        textField.setHeight(40)
        textField.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return textField
    }()
    
    private var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
     }()
    
    private var temperatureString: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        //label.text = "21"
        return label
    }()
    
    private var celsiusString: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        label.textColor = .white
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
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var maxTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        return label
    }()
    
    private var minTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
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
        image.setDimensions(height: 30, width: 40)
        return image
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
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
        image.setDimensions(height: 30, width: 40)
        return image
    }()
    
    private var windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
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
        image.setDimensions(height: 30, width: 40)
        return image
    }()
    
    private var pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
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
        collectionView.backgroundView = nil
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    //MARK: - mapkit
    
    private var mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.layer.cornerRadius = 20
        return map
    }()
    
    let locationManager = CLLocationManager()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConfigurationServices()
        setupBackgroundView()
        setupView()

    }
    
    private func setupBackgroundView(){
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupConfigurationServices(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    private func setupView(){

        title = "The Weather App"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = .black
        
        let addImage = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(plusIconPressed))
        
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
        stackHumidity.backgroundColor = .clear
        
        let stackWind = UIStackView(arrangedSubviews: [windIcon, windLabel])
        stackWind.axis = .vertical
        stackWind.spacing = 2
        stackWind.setDimensions(height: 80, width: 100)
        stackWind.alignment = .center
        stackWind.backgroundColor = .clear
        
        
        let stackPressure = UIStackView(arrangedSubviews: [pressureIcon, pressureLabel])
        stackPressure.axis = .vertical
        stackPressure.spacing = 2
        stackPressure.setDimensions(height: 80, width: 100)
        stackPressure.alignment = .center
        stackPressure.backgroundColor = .clear
        
        let stackHumidityWindPressure = UIStackView(arrangedSubviews: [stackHumidity, stackWind, stackPressure])
        stackHumidityWindPressure.axis = .horizontal
        stackHumidityWindPressure.spacing = 50
        stackHumidityWindPressure.alignment = .leading
        view.addSubview(stackHumidityWindPressure)
        stackHumidityWindPressure.anchor(top: stackIconAndTemperature.bottomAnchor, paddingTop: 10)
        stackHumidityWindPressure.centerX(inView: view)
        
        view.addSubview(collectionViewHour)
        collectionViewHour.anchor(top: stackHumidity.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor , paddingTop: 20, paddingLeft: 12, paddingRight: 12)
        collectionViewHour.setHeight(150)

        
        view.addSubview(mapView)
        mapView.anchor(top: collectionViewHour.bottomAnchor , left: view.leftAnchor, right: view.rightAnchor , paddingTop: 20, paddingLeft: 12, paddingRight: 12)
        mapView.setHeight(250)
        
    }
   
    //MARK: - Helpers
    
    @objc func locationPressed(_ sender: UIButton){
        locationManager.requestLocation()
    }
    
    @objc func plusIconPressed(){
        let addCityVC = AddCityViewController()
        addCityVC.modalPresentationStyle = .popover
        present(addCityVC, animated: true)
    }
    
    func getSelectedCityFromStorage(cityName: String){
        
        
        viewModel.getWeatherData(cityname: cityName)
        viewModel.getForecastData(cityname: cityName)
        print("elegi")
    }
    
    func saveCitiesInStorage(cityName: String){
        var cityListarray = userDefaults.object(forKey: "locations") as? [String] ?? [String]()
        
        if cityListarray.count == 5{
            cityListarray.removeFirst()
        }
        cityListarray.append(cityName)
        userDefaults.set(cityListarray, forKey: "locations")
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
        viewModel.getForecastData(cityname: city)
        saveCitiesInStorage(cityName: city)
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
        let width  = (view.frame.width-20)/4
        return CGSize(width: width, height: 80)
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
             
             let latitude = location.coordinate.latitude
             let longitude = location.coordinate.longitude
             
             viewModel.getWeatherData(lat: latitude, long: longitude, getLocation: true)
             viewModel.getForecastData(lat: latitude, long: longitude, getLocation: true)
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
