//
//  SettingsScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Foundation

protocol SettingsScreenViewProtocol: class {
    func setWeekMode(_ isWeekMode: Bool)
}

protocol SettingsScreenPresenterProtocol: class {
    func switcherValueChanged(_ isOn: Bool)
    func viewDidLoad()
    func closeView()
}

protocol SettingsScreenRouterProtocol {
    func routeToForecastScreen(delegate: MainForecastScreenPresenterProtocol?)
}
