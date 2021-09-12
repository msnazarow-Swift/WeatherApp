//
//  MainForecastScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MainForecastScreenAssembly {
    static func createMainForecastScreen(for cityId: Int, cityName: String) -> UIViewController {
        let viewController = MainForecastScreenViewController(style: .grouped)
        let router = MainForecastScreenRouter(view: viewController)
        let dataSource = MainForecastScreenDataSource()
        let presenter = MainForecastScreenPresenter(router: router, cityId: cityId, cityName: cityName, dataSource: dataSource)
        let interactor = MainForecastScreenInteractor()

        presenter.interactor = interactor
        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
