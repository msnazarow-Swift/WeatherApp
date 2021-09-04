//
//  MainScreenAssembly.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainScreenAssembly {
  func createMainScreen() -> MainScreenViewInput {
    let router = MainScreenRouter()
    let interactor = MainScreenInteractor()
    let presenter = MainScreenPresenter(router: router)
    let viewController = self.createMainScreenView()

    presenter.view = viewController
    presenter.interactor = interactor
    viewController.presenter = presenter

    return viewController
  }

  private
  func createMainScreenView() -> MainScreenViewController {
    let viewController = MainScreenViewController()

    return viewController
  }
}
