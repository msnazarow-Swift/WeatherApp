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
  func tableViewDidSelect(row: Int)
}

class SearchScreenPresenter {
    weak var view: SearchScreenViewInput?

    private let router: SearchScreenRouter

    var interactor: SearchScreenInteractorInput?

  var cities: [City] = []
    init(router: SearchScreenRouter) {
        self.router = router
    }
}

extension SearchScreenPresenter: SearchScreenViewOutput {
  func searchForCity(city: String) {
    var sections: [CitySectionModel] = []
    var models: [CityModel] = []
    guard let interactor = interactor, let view = view else {
      print("SearchScreenAssemle Error")
      return
    }
    interactor.searchWithPrefix(prefix: city) { cities in
      self.cities = cities
      cities.forEach { city in
        let model = CityModel(title: city.title)
        models.append(model)
      }
      sections.append(CitySectionModel(models))
      view.updateForSections(sections)
    }
  }
  func tableViewDidSelect(row: Int) {
    router.routeToWeekScreen(cityId: cities[row].woeid)
  }
}
