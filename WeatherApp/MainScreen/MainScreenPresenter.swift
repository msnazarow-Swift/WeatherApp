//
//  MainScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol MainScreenViewOutput: class {
  func viewDidLoad()
}

class MainScreenPresenter: MainScreenViewOutput {
  weak var view: MainScreenViewInput?

  private let router: MainScreenRouter

  var interactor: MainScreenInteractorInput?

  init(router: MainScreenRouter) {
    self.router = router
  }
  func viewDidLoad() {
    guard let interactor = interactor else {
      print("No interactor")
      return
    }
    interactor.get {
    }
  }
}
