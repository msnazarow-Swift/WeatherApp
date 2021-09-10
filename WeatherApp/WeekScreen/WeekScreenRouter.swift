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
    weak var view: WeekScreenViewController?

    init(view: WeekScreenViewController?) {
        self.view = view
    }

    func routeToDaySrceen(title: String, day: WeatherDay) {
        guard let view = view?.navigationController else { return }
        let dayScrenController = DayScreenAssembly.createDayScreen()
        dayScrenController.setCityLabel(city: title)
        if let temp = day.theTemp {
            dayScrenController.setDegreeLabel(degree: Int(temp))
        }
        dayScrenController.setWeatherLabel(weather: day.weatherStateName)
        if let min = day.minTemp, let max = day.maxTemp {
            dayScrenController.setMinMaxDegreeLabel(min: Int(min), max: Int(max))
        }
        dayScrenController.setDescriptionTable(day: day)
        let days = Calendar.current.dateComponents([.day], from: Date(), to: day.applicableDate).day!
        if days == 0 {
            dayScrenController.title = "Cегодня"
        } else if days == 1 {
            dayScrenController.title = "Завтра"
        } else {
            let weekFormatter = DateFormatter()
            weekFormatter.dateFormat = "EEEE"
            dayScrenController.title = weekFormatter.string(from: day.applicableDate)
        }
        view.pushViewController(dayScrenController, animated: true)
    }

    func routeToSearchScreen() {
        let searchScreen = SearchScreenAssembly.createSearchScreen()
        searchScreen.modalPresentationStyle = .fullScreen
        view?.present(searchScreen, animated: true, completion: nil)
    }
}
