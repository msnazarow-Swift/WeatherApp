//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchScreenRouter: SearchScreenRouterProtocol {
    weak var view: UIViewController?
    weak var delegate: PresenterPushViewProtocol?

    init(view: SearchScreenViewController?, delegate: PresenterPushViewProtocol?) {
        self.view = view
        self.delegate = delegate
    }

    func routeToMainForecastScreen(cityId: Int, cityName: String) {
        delegate?.pushNewCity(cityId: cityId, cityName: cityName)
        view?.dismiss(animated: true, completion: nil)
    }
}
