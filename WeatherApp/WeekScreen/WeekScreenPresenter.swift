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
    guard let interactor = interactor, let view = view else {
      print("Assemble error")
      return
    }
    view.setCityLabel(city: "Москва")
    view.setDegreeLabel(degree: 21)
    view.setWeatherLabel(weather: "Солнечно")
    view.setMinMaxDegreeLabel(min: 11, max: 30)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/mm/dd"
    let date = dateFormatter.date(from: "2020/4/18")!
    interactor.getWeekForecast(cityId: 2122265) { _ in }
    DayScreenInteractor().getWeatherForDay(cityId: 2122265, day: date) { dayWeather in
      print(dayWeather.last)
      let weekFormatter = DateFormatter()
      weekFormatter.dateFormat = "EEEE"
      guard let day = dayWeather.first else { print("NoData"); return }
      let model = DayModel(
        dayOfWeek: weekFormatter.string(from: day.applicableDate),
        weatherImg: URL(string: day.weatherStateAbbr)!,
        maxTemp: Int(day.maxTemp!),
        minTemp: Int(day.minTemp!)
      )
      var section: [WeatherSectionModel] = []
      section.append(WeatherSectionModel(model))
    }
    //    SearchScreenInteractor().searchWithPrefix(prefix: "Abs") { cities in print(cities.last) }
  }
}
extension WeekScreenPresenter: WeatherSectionModelDelegate {
  func didTapText(withEmail email: String) {
    print("Will text to \(email)")
  }

  func didTapCall(withPhone phoneNumber: String) {
    print("Will call to \(phoneNumber)")
  }
}
