//
//  MainForecastViewMock.swift
//  MainForecastScreenPresenterTest
//
//  Created by out-nazarov2-ms on 17.09.2021.
//
@testable import WeatherApp
import Foundation

class MainForecastViewMock: MainForecastScreenViewProtocol {
    func setCityLabel(city: String) {}

    func setWeatherLabel(weather: String) {}

    func setDegreeLabel(degree: Int) {}

    func setMinMaxDegreeLabel(min: Int, max: Int) {}

    func reloadTableViewData() {}

    func viewDidSetup() {}

    func updateMode() {}
}
