//
//  SettingsScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SettingsScreenAssembly {
    static func createSettingsScreen(delegate: PresenterUpdateProtocol?) -> UIViewController {
        let viewController = SettingsScreenViewController()
        let router = SettingsScreenRouter(view: viewController)
        let settingsStorageService = SettingsStorageService()
        let presenter = SettingsScreenPresenter(router: router,
                                                settingsStorageService: settingsStorageService,
                                                delegate: delegate)

        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }
}
