//
//  SettingsScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class SettingsScreenRouter: SettingsScreenRouterProtocol {
    weak var view: UIViewController?
    init(view: UIViewController?) {
        self.view = view
    }

    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
}
