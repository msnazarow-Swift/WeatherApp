//
//  SearchScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya
protocol SearchScreenInteractorInput: class {
  var presenter: SearchScreenInteractorOutput? { get set }
  func searchWithPrefix(prefix: String, complition: @escaping ([City]) -> Void)
}

protocol SearchScreenInteractorOutput: class {
}

class SearchScreenInteractor: SearchScreenInteractorInput {
  weak var presenter: SearchScreenInteractorOutput?

  func searchWithPrefix(prefix: String, complition: @escaping ([City]) -> Void) {
    let provider = MoyaProvider<WeatherService>()
    provider.request(.getCities(query: prefix)) { result in
      switch result {
      case .success(let response):
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          let cities = try response.map([WeatherCity].self, using: decoder).map { City($0) }
          complition(cities)
        } catch { print(error) }
      case .failure(let error):
        print(error)
      }
    }
  }
}
