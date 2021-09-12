//
//  WeekScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekScreenRouterInput {
    func routeToDaySrceen(cityName: String, day: WeatherDayResponse)
    func routeToSearchScreen()
    func routeToSettingsScreen()
}

class WeekScreenRouter: WeekScreenRouterInput {
    weak var view: WeekScreenViewController?

    init(view: WeekScreenViewController?) {
        self.view = view
    }

    func routeToDaySrceen(cityName: String, day: WeatherDayResponse) {
        guard let view = view?.navigationController else { return }
        let dayScrenController = DayScreenAssembly.createDayScreen(with: cityName, for: day)

        view.pushViewController(dayScrenController, animated: true)
    }

    func routeToSearchScreen() {
        let searchScreen = SearchScreenAssembly.createSearchScreen()
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }

    func routeToSettingsScreen() {
        let settingScreen = SettingsScreenAssembly.createSettingsScreen()
        settingScreen.modalPresentationStyle = .fullScreen
        view?.present(settingScreen, animated: true, completion: nil)
    }
}
