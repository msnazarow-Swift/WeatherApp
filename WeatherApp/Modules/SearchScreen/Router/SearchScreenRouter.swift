//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchScreenRouterInput {
    func routeToMainForecastScreen(cityId: Int, cityName: String)
}

class SearchScreenRouter: SearchScreenRouterInput {
    weak var view: SearchScreenViewController?
    weak var delegate: PresenterPushViewProtocol?

    init(view: SearchScreenViewController?, delegate: PresenterPushViewProtocol?) {
        self.view = view
        self.delegate = delegate
    }

    func routeToMainForecastScreen(cityId: Int, cityName: String) {
        delegate?.pushNewCity(cityId: cityId, cityName: cityName)
//        let MainForecastScreen = MainForecastScreenAssembly.createMainForecastScreen(for: cityId, cityName: cityName)
//        MainForecastScreen.modalPresentationStyle = .fullScreen
//        delegate.push(MainForecastScreen)
//        delegate?.pushViewController(MainForecastScreen, animated: true)
//        if let root = self.view?.view.window?.rootViewController, let view = root as? UINavigationController {
//    		view.pushViewController(MainForecastScreen, animated: true)
//        }
        view?.dismiss(animated: true, completion: nil)
    }
}
