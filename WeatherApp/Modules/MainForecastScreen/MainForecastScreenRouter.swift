//
//  MainForecastScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainForecastScreenRouter: MainForecastScreenRouterProtocol {
    weak var view: MainForecastScreenViewController?

    init(view: MainForecastScreenViewController?) {
        self.view = view
    }

    func routeToDaySrceen(cityName: String, day: WeatherDayResponse) {
        guard let view = view?.navigationController else { return }
        let dayScrenController = DayDetailsScreenAssembly.createDayDetailsScreen(with: cityName, for: day)

        view.pushViewController(dayScrenController, animated: true)
    }

    func routeToSearchScreen(delegate: PresenterPushViewProtocol?) {
        let searchScreen = SearchScreenAssembly.createSearchScreen(delegate: delegate)
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }

    func routeToSettingsScreen(delegate: MainForecastScreenPresenterProtocol?) {
        let settingScreen = SettingsScreenAssembly.createSettingsScreen(delegate: delegate)
        settingScreen.modalPresentationStyle = .fullScreen
        view?.present(settingScreen, animated: true, completion: nil)
    }
    func routeToNewCity(cityId: Int, cityName: String) {
        let forecastScreen = MainForecastScreenAssembly.createMainForecastScreen(for: cityId, cityName: cityName)
        view?.navigationController?.pushViewController(forecastScreen, animated: true)
    }
}
