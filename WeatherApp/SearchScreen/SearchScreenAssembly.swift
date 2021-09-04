//
//  SearchScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SearchScreenAssembly {
    func createSearchScreen(appRouter: AppRouter?) -> SearchScreenViewInput {
        let router = SearchScreenRouter(appRouter: appRouter)
        let presenter = SearchScreenPresenter(router: router)
        let viewController = self.createSearchScreenView()

        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }

    private
    func createSearchScreenView() -> SearchScreenViewController {
        let viewController = SearchScreenViewController()

        return viewController
    }
}
