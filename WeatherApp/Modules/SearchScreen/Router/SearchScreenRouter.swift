//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchScreenRouterInput {
    func routeToWeekScreen(cityId: Int, cityName: String)
}

class SearchScreenRouter: SearchScreenRouterInput {
    weak var view: SearchScreenViewController?
    init(view: SearchScreenViewController?) {
        self.view = view
    }

    func routeToWeekScreen(cityId: Int, cityName: String) {
        let weekScreen = WeekScreenAssembly.createWeekScreen(for: cityId, cityName: cityName)
        weekScreen.modalPresentationStyle = .fullScreen
        if let root = self.view?.view.window?.rootViewController, let view = root as? UINavigationController {
    		view.pushViewController(weekScreen, animated: true)
        }
        view?.dismiss(animated: true, completion: nil)
    }
}
