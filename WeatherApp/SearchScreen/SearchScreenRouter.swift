//
//  SearchScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchScreenRouterInput {
  func routeToWeekScreen(cityId: Int)
}

class SearchScreenRouter: SearchScreenRouterInput {
  weak var view: SearchScreenViewInput?
  init(appRouter: AppRouter?) {
  }
  func routeToWeekScreen(cityId: Int) {
    guard let view = view?.viewController.navigationController else {
      return
    }
    let weekScreen = WeekScreenAssembly().createWeekScreen(appRouter: nil)
    weekScreen.loadForCity(cityId: cityId)
    if let viewController = weekScreen as? UIViewController {
      view.pushViewController(viewController, animated: true)
    }
  }
}
