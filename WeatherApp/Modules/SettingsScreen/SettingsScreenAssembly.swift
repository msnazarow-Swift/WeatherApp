//
//  SettingsScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SettingsScreenAssembly {
    static func createSettingsScreen() -> SettingsScreenViewController {
        let router = SettingsScreenRouter()
        let presenter = SettingsScreenPresenter(router: router)
        let viewController = SettingsScreenViewController()

        presenter.view = viewController
        viewController.presenter = presenter

        return viewController
    }
}
