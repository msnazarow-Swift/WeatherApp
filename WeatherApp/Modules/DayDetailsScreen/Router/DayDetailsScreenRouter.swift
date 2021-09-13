//
//  DayDetailsScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class DayDetailsScreenRouter: DayDetailsScreenRouterProtocol {
    weak var view: DayDetailsScreenViewController?

    init(view: DayDetailsScreenViewController?) {
        self.view = view
    }

    func routeToSearchScreen(delegate: PresenterPushViewProtocol?) {
        let searchScreen = SearchScreenAssembly.createSearchScreen(delegate: delegate)
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }

    func routeToNewCity(cityId: Int, cityName: String) {
        let forecastScreen = MainForecastScreenAssembly.createMainForecastScreen(for: cityId, cityName: cityName)
        view?.navigationController?.pushViewController(forecastScreen, animated: true)
    }
}
