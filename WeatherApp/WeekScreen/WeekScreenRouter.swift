//
//  WeekScreenRouter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol WeekScreenRouterInput {
  func routeToDaySrceen(title: String, day: WeatherDay)
  func routeToSearchScreen()
}

class WeekScreenRouter: WeekScreenRouterInput {
  weak var view: WeekScreenViewInput?

  init(appRouter: AppRouter?) {
  }
  func routeToDaySrceen(title: String, day: WeatherDay) {
    guard let view = view?.viewController.navigationController else {
      return
    }
    let dayScrenController = DayScreenAssembly().createDayScreen(appRouter: nil)
    dayScrenController.setCityLabel(city: title)
    if let temp = day.theTemp {
      dayScrenController.setDegreeLabel(degree: Int(temp))
    }
    dayScrenController.setWeatherLabel(weather: day.weatherStateName)
    if let min = day.minTemp, let max = day.maxTemp {
      dayScrenController.setMinMaxDegreeLabel(min: Int(min), max: Int(max))
    }
    dayScrenController.setDescriptionTable(day: day)
    if let viewController = dayScrenController as? UIViewController {
      let days = Calendar.current.dateComponents([.day], from: Date(), to: day.applicableDate).day!
      if days == 0 {
        viewController.title = "Cегодня"
      } else if days == 1 {
        viewController.title = "Завтра"
      } else {
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "EEEE"
        viewController.title = weekFormatter.string(from: day.applicableDate)
      }
      view.pushViewController(viewController, animated: true)
    }
  }
  func routeToSearchScreen() {
    guard let view = view?.viewController.navigationController else {
      return
    }
    let searchScreen = SearchScreenAssembly().createSearchScreen(appRouter: nil)
    if let viewController = searchScreen as? UIViewController {
      view.pushViewController(viewController, animated: true)
    }
  }
}
