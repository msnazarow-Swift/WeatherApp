//
//  WeekScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol WeekScreenViewOutput: class {
  func viewDidLoad()
}

class WeekScreenPresenter: WeekScreenViewOutput {
    weak var view: WeekScreenViewInput?

    private let router: WeekScreenRouter

    var interactor: WeekScreenInteractorInput?

    init(router: WeekScreenRouter) {
        self.router = router
    }
  func viewDidLoad() {
    guard let interactor = interactor else {
      print("No interactor")
      return
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/mm/dd"
    let date = dateFormatter.date(from: "2020/4/18")!
    interactor.getWeekForecast(cityId: 2122265) { _ in }
    DayScreenInteractor().getWeatherForDay(cityId: 2122265, day: date, complition: { _ in })
    SearchScreenInteractor().searchWithPrefix(prefix: "Abs") { cities in print(cities.last) }
  }
}
