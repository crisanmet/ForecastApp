//
//  CityStorageViewModel.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 30/06/2022.
//

import Foundation

class CityStorageViewModel {
    
    let userDefaults = UserDefaults.standard
    
    func cityListArray() -> [String]{
           let cityListArray = userDefaults.object(forKey: "locations") as? [String] ?? [String]()
           return cityListArray
    }
       
    func returnCityFromTableView(_ index: Int) -> String {
           let cityListArray = cityListArray()
           return cityListArray[index]
    }
       
    func deleteCity(_ delete: Int) -> Void {
        var cityListArray = cityListArray()
        cityListArray.remove(at: delete)
        userDefaults.set(cityListArray, forKey: "locations")
    }
}
