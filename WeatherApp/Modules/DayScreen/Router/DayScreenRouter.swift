//
//  DayScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DayScreenRouterInput {
    func routeToSearchScreen(isWeekMode: Bool)
}

class DayScreenRouter: DayScreenRouterInput {
    weak var view: DayScreenViewController?

    init(view: DayScreenViewController?) {
        self.view = view
    }

    func routeToSearchScreen(isWeekMode: Bool) {
        let searchScreen = SearchScreenAssembly.createSearchScreen(isWeekMode: isWeekMode)
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }
}
