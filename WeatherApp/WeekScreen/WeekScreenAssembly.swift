//
//  WeekScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AppRouter {}

class WeekScreenAssembly {
    func createWeekScreen(appRouter: AppRouter?) -> WeekScreenViewInput {
        let router = WeekScreenRouter(appRouter: appRouter)
        let presenter = WeekScreenPresenter(router: router)
        let viewController = createWeekScreenView()
        let interactor = WeekScreenInteractor()

        presenter.interactor = interactor
        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }

    private
    func createWeekScreenView() -> WeekScreenViewController {
        let viewController = WeekScreenViewController()

        return viewController
    }
}
