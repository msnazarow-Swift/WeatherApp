//
//  DayScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol DayScreenViewOutput: class {
}

class DayScreenPresenter: DayScreenViewOutput {
  weak var view: DayScreenViewInput?

  private let router: DayScreenRouter

  var interactor: DayScreenInteractorInput?

  init(router: DayScreenRouter) {
    self.router = router
  }
}
