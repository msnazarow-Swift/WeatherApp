//
//  MainScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

protocol MainScreenInteractorInput: class {
  var presenter: MainScreenInteractorOutput? { get set }
  func get(complition: @escaping () -> Void)
}

protocol MainScreenInteractorOutput: class {
}

class MainScreenInteractor: MainScreenInteractorInput {
  weak var presenter: MainScreenInteractorOutput?
  func get(complition: @escaping () -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getCities(query: "Mos")) { [weak self] result in
      switch result {
      case .success(let response):
        let data = response.data

        do {
          let json = try response.map([WeatherCity].self).map { City($0) }
          print(json[0].lattLong)
          let result = try JSONDecoder().decode(WeatherApiResults<WeatherCity>.self, from: data)
        } catch { print(error) }
      case .failure(let error):
        print(error)
      }
    }
  }
}
