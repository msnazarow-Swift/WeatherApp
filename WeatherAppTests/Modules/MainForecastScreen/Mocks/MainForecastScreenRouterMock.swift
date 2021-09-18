//
//  MainForecastRouterMock.swift
//  MainForecastScreenPresenterTest
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import Foundation

class MainForecastRouterMock: MainForecastScreenRouterProtocol {
    func routeToDaySrceen(cityName: String, day: WeatherDayResponse) {}

    func routeToSearchScreen(delegate: PresenterPushViewProtocol?) {}

    func routeToSettingsScreen(delegate: PresenterUpdateProtocol?) {}

    func routeToNewCity(cityId: Int, cityName: String) {}
}
