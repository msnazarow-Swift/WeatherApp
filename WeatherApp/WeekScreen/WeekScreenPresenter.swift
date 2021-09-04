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
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/mm/dd"
    let date = dateFormatter.date(from: "2020/4/18")!
    view.setCityLabel(city: "Москва")
    view.setDegreeLabel(degree: 21)
    view.setWeatherLabel(weather: "Солнечно")
    view.setMinMaxDegreeLabel(min: 11, max: 30)

    interactor.getImages { images in
      interactor.saveImages(images)
    }


    interactor.getWeekForecast(cityId: 2122265) { weekWeather in
      print(weekWeather.consolidatedWeather.first)
      let weekFormatter = DateFormatter()
      weekFormatter.dateFormat = "EEEE"
      let days = weekWeather.consolidatedWeather
      var sections: [DaySectionModel] = []

//      guard let days = weekWeather.consolidatedWeather.first else { print("NoData"); return }
      days.forEach { day in
        print(day)
        let model = DayModel(
          dayOfWeek: weekFormatter.string(from: day.applicableDate),
          weatherImg: day.weatherStateAbbr,
          maxTemp: Int(day.maxTemp!),
          minTemp: Int(day.minTemp!)
        )
        sections.append(DaySectionModel(model))
      }
      view.updateForSections(sections)
    }

    //    SearchScreenInteractor().searchWithPrefix(prefix: "Abs") { cities in print(cities.last) }
  }
}
extension WeekScreenPresenter: DescriptionSectionModelDelegate {
  func didTapText(withEmail email: String) {
    print("Will text to \(email)")
  }

  func didTapCall(withPhone phoneNumber: String) {
    print("Will call to \(phoneNumber)")
  }
}
