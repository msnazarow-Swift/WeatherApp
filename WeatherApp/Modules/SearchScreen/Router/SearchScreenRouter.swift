//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchScreenRouterInput {
    func routeToWeekScreen(cityId: Int)
}

class SearchScreenRouter: SearchScreenRouterInput {
    weak var view: SearchScreenViewController?
    init(view: SearchScreenViewController?) {
        self.view = view
    }

    func routeToWeekScreen(cityId: Int) {
        let weekScreen = WeekScreenAssembly.createWeekScreen(for: cityId)
        weekScreen.modalPresentationStyle = .fullScreen
        if let root = self.view?.view.window?.rootViewController, let view = root as? UINavigationController {
    		view.pushViewController(weekScreen, animated: true)
        }
        view?.dismiss(animated: false, completion: nil)
    }
}
