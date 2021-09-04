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
  func get(complition: @escaping () -> Void)
}

protocol WeekScreenInteractorOutput: class {
}

class WeekScreenInteractor: WeekScreenInteractorInput {
  weak var presenter: WeekScreenInteractorOutput?
  func get(complition: @escaping () -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getCities(query: "Mos")) { [weak self] result in
      switch result {
      case .success(let response):
        do {
          let json = try response.map([WeatherCity].self).map { City($0) }
          print(json[0].lattLong)
        } catch { print(error) }
      case .failure(let error):
        print(error)
      }
    }
  }
}
