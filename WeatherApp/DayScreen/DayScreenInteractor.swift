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
  func getWeatherForDay(cityId: Int, day: Date, complition: @escaping () -> Void)
}

protocol DayScreenInteractorOutput: class {
}

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

class DayScreenInteractor: DayScreenInteractorInput {
    weak var presenter: DayScreenInteractorOutput?
//https://www.metaweather.com/api/location/44418/2013/4/27/
  func getWeatherForDay(cityId: Int, day: Date, complition: @escaping () -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getDay(woeid: 44418, date: "2013/4/27")) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)

          try print(decoder.decode([WeatherDay].self, from: response.data))
//         try print(response.mapJSON())
//          let json = try response.map([WeatherDay].self)
//          print(json)
        } catch { print(error) }
      case .failure(let error):
        print(error)
      }
    }
  }
}
