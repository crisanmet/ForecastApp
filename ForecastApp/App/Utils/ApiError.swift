//
//  ApiError.swift
//  ForecastApp
//
//  Created by Cristian Sancricca on 25/06/2022.
//

import Foundation

enum ApiError {
    case noWeatherData
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noWeatherData : return "Oops! City not found..."
        }
    }
}
