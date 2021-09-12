//
//  DayDetailsScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Foundation

protocol DayDetailsScreenViewInput: AnyObject {
    func setTitle(_ title: String)
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func update()
}

protocol DayDetailsScreenViewOutput: AnyObject {
    func searchButtonTapped()
    func setDescriptionTable(day: WeatherDayResponse)
    var dataSource: DayDetailsScreenDataSource { get }
    func viewDidLoad()
}

protocol DayDetailsScreenRouterProtocol {
    func routeToSearchScreen(delegate: PresenterPushViewProtocol?)
    func routeToNewCity(cityId: Int, cityName: String)
}
