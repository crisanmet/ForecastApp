//
//  APIManager.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation
import Alamofire

struct APIManager {
    
    
    static let shared = APIManager()
    
    private init(){}
    
    func get(url: String,completion: @escaping (Result<Data?, AFError>) -> ()){
        
        AF.request(url, method: .get).response { response in
            completion(response.result)
        }
    }
}
