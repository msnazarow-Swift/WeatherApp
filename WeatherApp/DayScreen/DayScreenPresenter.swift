//
//  DayScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol DayScreenViewOutput: class {
  func viewDidLoad()
}

class DayScreenPresenter: DayScreenViewOutput {
    weak var view: DayScreenViewInput?

    private let router: DayScreenRouter

    var interactor: DayScreenInteractorInput?


    init(router: DayScreenRouter) {
        self.router = router
    }

  func viewDidLoad() {
    guard let interactor = interactor, let view = view else {
      print("DayScreenAssemble error")
      return
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/mm/dd"
    let date = dateFormatter.date(from: "2020/4/18")!
    view.setCityLabel(city: "Москва")
    view.setDegreeLabel(degree: 21)
    view.setWeatherLabel(weather: "Солнечно")
    view.setMinMaxDegreeLabel(min: 11, max: 30)
    interactor.getWeatherForDay(cityId: 2122265, day: date) { dayWeather in
      print(dayWeather.last)
      let weekFormatter = DateFormatter()
      weekFormatter.dateFormat = "EEEE"
      guard let day = dayWeather.first else { print("NoData"); return }
      let model = DayModel(
        dayOfWeek: weekFormatter.string(from: day.applicableDate),
        weatherImg: day.weatherStateAbbr,
        maxTemp: Int(day.maxTemp!),
        minTemp: Int(day.minTemp!)
      )
      var section: [DaySectionModel] = []
      section.append(DaySectionModel(model))
    }
  }
}
