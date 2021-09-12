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
    weak var delegate: PresenterPushViewProtocol?

    init(view: SearchScreenViewController?, delegate: PresenterPushViewProtocol?) {
        self.view = view
        self.delegate = delegate
    }

    func routeToWeekScreen(cityId: Int, cityName: String) {
        delegate?.pushNewCity(cityId: cityId, cityName: cityName)
//        let weekScreen = WeekScreenAssembly.createWeekScreen(for: cityId, cityName: cityName)
//        weekScreen.modalPresentationStyle = .fullScreen
//        delegate.push(weekScreen)
//        delegate?.pushViewController(weekScreen, animated: true)
//        if let root = self.view?.view.window?.rootViewController, let view = root as? UINavigationController {
//    		view.pushViewController(weekScreen, animated: true)
//        }
        view?.dismiss(animated: true, completion: nil)
    }
}
