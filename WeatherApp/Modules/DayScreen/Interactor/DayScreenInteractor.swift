//
//  DayScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

protocol DayScreenInteractorInput: class {
    func getWeatherForDay(cityId: Int, day: Date, complition: @escaping ([WeatherDayResponse]) -> Void)
}

protocol DayScreenInteractorOutput: class {}

class DayScreenInteractor: DayScreenInteractorInput {
    weak var presenter: DayScreenInteractorOutput?

    func getWeatherForDay(cityId: Int, day: Date, complition: @escaping ([WeatherDayResponse]) -> Void) {
        let provider = MoyaProvider<WeatherTarget>()
        provider.request(.getDay(woeid: cityId, date: day)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let weatherDay = try response.map([WeatherDayResponse].self, using: decoder)
                    complition(weatherDay)
                } catch {
                    do {
                        _ = try response.map(NotFoundResponse.self, using: decoder)
                        print("Error: cityId = \(cityId) with day = \(day) Not found")
                    } catch {
                        print(error)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
