//
//  DayScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DayScreenAssembly {
    func createDayScreen(appRouter: AppRouter?) -> DayScreenViewController {
        let viewController = DayScreenViewController()
        let router = DayScreenRouter(view: viewController)
        let presenter = DayScreenPresenter(router: router)
        let interactor = DayScreenInteractor()
        presenter.view = viewController
        viewController.presenter = presenter
        presenter.interactor = interactor
        return viewController
    }
}
