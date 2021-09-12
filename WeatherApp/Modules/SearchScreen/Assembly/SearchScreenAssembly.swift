//
//  SearchScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SearchScreenAssembly {
    static func createSearchScreen() -> SearchScreenViewController {
        let viewController = SearchScreenViewController()
        let router = SearchScreenRouter(view: viewController)
        let presenter = SearchScreenPresenter(router: router)
        let interactor = SearchScreenInteractor()
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.presenter = presenter
        router.view = viewController
        return viewController
    }
}
