//
//  WeekScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekScreenRouterInput {
    func routeToDaySrceen(cityName: String, day: WeatherDayResponse, isWeekMode: Bool)
    func routeToSearchScreen(isWeekMode: Bool)
    func routeToSettingsScreen(isWeekMode: Bool)
}

class WeekScreenRouter: WeekScreenRouterInput {
    weak var view: WeekScreenViewController?

    init(view: WeekScreenViewController?) {
        self.view = view
    }

    func routeToDaySrceen(cityName: String, day: WeatherDayResponse, isWeekMode: Bool) {
        guard let view = view?.navigationController else { return }
        let dayScrenController = DayScreenAssembly.createDayScreen(with: cityName, for: day, isWeekMode: isWeekMode)

        view.pushViewController(dayScrenController, animated: true)
    }

    func routeToSearchScreen(isWeekMode: Bool) {
        let searchScreen = SearchScreenAssembly.createSearchScreen(isWeekMode: isWeekMode)
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }

    func routeToSettingsScreen(isWeekMode: Bool) {
        let settingScreen = SettingsScreenAssembly.createSettingsScreen(isWeekMode: isWeekMode)
        settingScreen.modalPresentationStyle = .fullScreen
        view?.present(settingScreen, animated: true, completion: nil)
    }
}
