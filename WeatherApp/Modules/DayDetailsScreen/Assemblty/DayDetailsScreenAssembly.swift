//
//  DayDetailsScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum DayDetailsScreenAssembly {
    static func createDayDetailsScreen(with cityTitle: String, for day: WeatherDayResponse) -> UIViewController {
        let viewController = DayDetailsScreenViewController()
        let router = DayDetailsScreenRouter(view: viewController)
        let dataSource = DayDetailsScreenDataSource()
        let presenter = DayDetailsScreenPresenter(router: router, title: cityTitle, day: day, dataSource: dataSource)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
}
