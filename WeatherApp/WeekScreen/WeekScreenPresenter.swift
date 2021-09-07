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
  func tableViewDidSelect(row: Int)
  func searchButtonTapped()
}

class WeekScreenPresenter: WeekScreenViewOutput {
  weak var view: WeekScreenViewInput?

  private let router: WeekScreenRouterInput

  var interactor: WeekScreenInteractorInput?

  var weatherWeek: WeatherWeek!

  var cityId: Int!
  init(router: WeekScreenRouterInput) {
    self.router = router
  }

  func viewDidLoad() {
    guard let interactor = interactor, let view = view else {
      print("WeekScreenAssemble error")
      return
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/mm/dd"
    let date = dateFormatter.date(from: "2020/4/18")!
    interactor.getImages { images in
      interactor.saveImages(images)
    }


    interactor.getWeekForecast(cityId: 2122265) { weatherWeek in
      //      print(weekWeather.consolidatedWeather.first)
      self.weatherWeek = weatherWeek
      let weekFormatter = DateFormatter()
      weekFormatter.dateFormat = "EEEE"
      let days = weatherWeek.consolidatedWeather
      var sections: [DaySectionModel] = []
      var models: [DayModel] = []
      days.forEach { day in
        //        print(day)
        let model = DayModel(
          dayOfWeek: weekFormatter.string(from: day.applicableDate),
          weatherImg: day.weatherStateAbbr,
          maxTemp: Int(day.maxTemp!),
          minTemp: Int(day.minTemp!)
        )
        models.append(model)
      }
      sections.append(DaySectionModel(models))
      view.updateForSections(sections)
      view.setCityLabel(city: weatherWeek.title)
      guard let day = days.first else { return }
      if let temp = day.theTemp {
        view.setDegreeLabel(degree: Int(temp))
      }
      view.setWeatherLabel(weather: day.weatherStateName)
      if let minTemp = day.minTemp, let maxTemp = day.maxTemp {
        view.setMinMaxDegreeLabel(min: Int(minTemp), max: Int(maxTemp))
      }

      //    SearchScreenInteractor().searchWithPrefix(prefix: "Abs") { cities in print(cities.last) }
    }
  }
  func tableViewDidSelect(row: Int) {
    router.routeToDaySrceen(title: weatherWeek.title, day: weatherWeek.consolidatedWeather[row])
  }
  func searchButtonTapped() {
    router.routeToSearchScreen()
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
