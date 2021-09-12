//
//  SearchScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class SearchScreenPresenter {
    weak var view: SearchScreenViewProtocol?

    private let router: SearchScreenRouter

    var interactor: SearchScreenInteractorProtocol?

    var cities: [WeatherCityModel] = []

    let dataSource: SearchScreenDataSourceProtocol

    init(router: SearchScreenRouter, dataSource: SearchScreenDataSourceProtocol) {
        self.router = router
        self.dataSource = dataSource
    }
}

extension SearchScreenPresenter: SearchScreenPresenterProtocol {
    func searchForCity(city: String) {
        var sections: [CitySectionModel] = []
        var models: [CityModel] = []
        guard let interactor = interactor, let view = view else {
            print("SearchScreenAssemle Error")
            return
        }
        interactor.searchWithSubstring(city) { [weak self] cities in
            self?.cities = cities
            cities.forEach { city in
                let model = CityModel(title: city.title)
                models.append(model)
            }
            sections.append(CitySectionModel(models))
            self?.dataSource.updateForSections(sections)
            view.update()
        }
    }

    func tableViewDidSelect(row: Int) {
        router.routeToMainForecastScreen(cityId: cities[row].woeid, cityName: cities[row].title)
    }
}
