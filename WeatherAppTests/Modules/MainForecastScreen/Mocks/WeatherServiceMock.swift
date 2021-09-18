//
//  WeatherServiceMock.swift
//  WeatherAppTests
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import UIKit
import Moya

class WeatherServiceMock: WeatherServiceProtocol {
    func getWeekForCity(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void) {
        complition(weatherWeekResponse)
    }

    func getDayForCity(cityId: Int, day: Date, complition: @escaping (Result<WeatherDayResponse, Error>) -> Void) {
        complition(.success(weatherDayResponse))
    }

    func getImage(for arrb: String, complition: @escaping (Result<Image, Error>) -> Void) {
        complition(.success(UIImage()))
    }
}
