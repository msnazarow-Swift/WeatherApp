//
//  WeekScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

protocol WeekScreenInteractorInput: class {
  var presenter: WeekScreenInteractorOutput? { get set }
  func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void)
}

protocol WeekScreenInteractorOutput: class {
}
class WeekScreenInteractor: WeekScreenInteractorInput {
  weak var presenter: WeekScreenInteractorOutput?
  func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getWeek(woeid: cityId)) {result in
      switch result {
      case .success(let response):
        let decoder = JSONDecoder()
          decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
          decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          let weatherWeek = try response.map(WeatherWeek.self, using: decoder)
          complition(weatherWeek)
        } catch {
          do {
            let notFound = try response.map(NotFound.self, using: decoder)
            print("Error: cityId = \(cityId) not found")
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
