//
//  SettingsScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SettingsScreenRouter {
    weak var view: UIViewController?
    init(view: UIViewController?) {
        self.view = view
    }
    func routeToForecastScreen(delegate: WeekScreenViewOutput?) {
//        if let view = view?.view.window?.rootViewController as? UINavigationController {
//            let weekScreen = WeekScreenAssembly.createWeekScreen(for: <#T##Int#>, isWeekMode: <#T##Bool#>)
//            view.setViewControllers(<#T##viewControllers: [UIViewController]##[UIViewController]#>, animated: <#T##Bool#>)
//        }
        view?.dismiss(animated: true, completion: nil)
        delegate?.viewDidLoad()
    }
}
