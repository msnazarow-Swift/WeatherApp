//
//  SearchScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol SearchScreenViewOutput: class {
  func searchForCity(city: String)
}

class SearchScreenPresenter {
    weak var view: SearchScreenViewInput?

    private let router: SearchScreenRouter

    var interactor: SearchScreenInteractorInput?

    init(router: SearchScreenRouter) {
        self.router = router
    }
}

extension SearchScreenPresenter: SearchScreenViewOutput {
  func searchForCity(city: String) {
    interactor?.searchWithPrefix(prefix: city) { cities in
      cities.forEach { city in
        let model = CityModel(title: city.title)
      }
    }
  }
}
