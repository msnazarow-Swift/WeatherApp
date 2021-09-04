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
  var presenter: DayScreenInteractorOutput? { get set }
  func getWeatherForDay(cityId: Int, day: Date, complition: @escaping ([WeatherDay]) -> Void)
}

protocol DayScreenInteractorOutput: class {
}

class DayScreenInteractor: DayScreenInteractorInput {
  weak var presenter: DayScreenInteractorOutput?

  func getWeatherForDay(cityId: Int, day: Date, complition: @escaping ([WeatherDay]) -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getDay(woeid: cityId, date: day)) { result in
      switch result {
      case .success(let response):
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          let weatherDay = try response.map([WeatherDay].self, using: decoder)
          complition(weatherDay)
        } catch {
          do {
              try response.map(NotFound.self, using: decoder)
            print("Error: cityId = \(cityId) with day = \(day) Not found")
          } catch {
            print(error)
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }
}
