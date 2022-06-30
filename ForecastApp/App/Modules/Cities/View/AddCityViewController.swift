//
//  AddCityViewController.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 29/06/2022.
//

import UIKit

class AddCityViewController: UIViewController {
    
    //MARK: - Properties
    
    //let userDefaults = UserDefaults.standard
    
    lazy var viewModel: CityStorageViewModel = {
        let viewModel = CityStorageViewModel()
        return viewModel
    }()
    
    lazy var cityTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CityNameTableViewCell.self, forCellReuseIdentifier: CityNameTableViewCell.identifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cityTable)

    }
    
    override func viewWillAppear(_ animated: Bool){
          super.viewWillAppear(animated)
          //cityListArray()
          cityTable.reloadData()
      }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cityTable.frame = view.bounds
    }
    
    //MARK: - Helpers
    
//    func cityListArray() -> [String]{
//           let cityListArray = userDefaults.object(forKey: "locations") as? [String] ?? [String]()
//           return cityListArray
//    }
//       
//    func returnCityFromTableView(_ index: Int) -> String {
//           let cityListArray = cityListArray()
//           return cityListArray[index]
//    }
//       
//    func deleteCity(_ delete: Int) -> Void {
//        var cityListArray = cityListArray()
//        cityListArray.remove(at: delete)
//        userDefaults.set(cityListArray, forKey: "locations")
//    }

}

//MARK: - Table view Delegate

extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityListArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityNameTableViewCell.identifier, for: indexPath) as? CityNameTableViewCell else {
                return UITableViewCell()
             }
        cell.cityName.text = viewModel.cityListArray()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCity(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let WeatherVC = WeatherViewController()
        let cityName = viewModel.returnCityFromTableView(indexPath.row)
    
        DispatchQueue.main.async { [weak self] in
            WeatherVC.getSelectedCityFromStorage(cityName: cityName)
            self?.dismiss(animated: true)
        }
      }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "We only store the last 5 searchs..."
    }
    
}
