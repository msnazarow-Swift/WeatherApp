//
//  DayScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DayScreenAssembly {
    static func createDayScreen(for day: WeatherDayResponse) -> DayScreenViewController {
        let viewController = DayScreenViewController()// (style: .grouped)
        let router = DayScreenRouter(view: viewController)
        let presenter = DayScreenPresenter(router: router, day: day)
        let interactor = DayScreenInteractor()
        presenter.view = viewController
        viewController.presenter = presenter
        presenter.interactor = interactor
        return viewController
    }
}
