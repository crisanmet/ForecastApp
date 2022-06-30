//
//  TestWeatherViewModel.swift
//  ForecastAppTests
//
//  Created by Cristian Sancricca on 30/06/2022.
//

import XCTest
@testable import ForecastApp

class TestWeatherViewModel: XCTestCase {

    var sut: WeatherViewModel!
        
    override func setUpWithError() throws {
            
    }

    override func tearDownWithError() throws {
      sut = nil
    }

    func test_WeatherViewModel_GetsWeatherData_ShouldReturnData(){
         let mock = MockForecastServiceSuccess()
         sut = WeatherViewModel(weatherService: mock)
         let expectation = XCTestExpectation(description: "Should return data")
         
        sut.weatherService.fetchWeather(cityName: "San Francisco", getLocation: false, lat: 0.0, long: 0.0) { weather in
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather.main.temp, 13.37)
            expectation.fulfill()
        } onError: { error in
            XCTAssertTrue(error.isEmpty)
            expectation.fulfill()
        }
         wait(for: [expectation], timeout: 3)
     }
    
    func test_characterViewModel_GetsCharacterData_ShouldShowError(){
        let mock = MockForecastServiceFail()
        sut = WeatherViewModel(weatherService: mock)
        
        let expectation = XCTestExpectation(description: "Should return error")
        
        sut.weatherService.fetchWeather(cityName: "Test Fail", getLocation: false, lat: 0.0, long: 0.0) { weather in
            XCTAssertNil(weather)
            expectation.fulfill()
        } onError: { error in
            XCTAssertEqual(error, "Oops! City not found...")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
        
    }
}
