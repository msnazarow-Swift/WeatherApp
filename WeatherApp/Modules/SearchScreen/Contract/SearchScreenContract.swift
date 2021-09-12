//
//  SearchScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Foundation

protocol SearchScreenViewProtocol: class {
   func update()
}

protocol PresenterPushViewProtocol: class {
    func pushNewCity(cityId: Int, cityName: String)
}

protocol SearchScreenPresenterProtocol: class {
    func searchForCity(city: String)
    func tableViewDidSelect(row: Int)
    var dataSource: SearchScreenDataSource { get }
}

protocol SearchScreenInteractorProtocol: class {
    func searchWithSubstring(_ substring: String, complition: @escaping ([WeatherCityModel]) -> Void)
}

protocol SearchScreenRouterProtocol {
    func routeToMainForecastScreen(cityId: Int, cityName: String)
}
