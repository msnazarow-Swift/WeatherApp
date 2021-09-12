//
//  DayScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DayScreenViewOutput: class {
    func searchButtonTapped()
    func setDescriptionTable(day: WeatherDayResponse)
    var dataSource: DayScreenDataSource { get }
    func viewDidLoad()
}

class DayScreenPresenter: DayScreenViewOutput, PresenterPushViewProtocol {
    weak var view: DayScreenViewInput?
    var dataSource = DayScreenDataSource()
    private let router: DayScreenRouter
    private let title: String
    private let day: WeatherDayResponse

    init(router: DayScreenRouter, title: String, day: WeatherDayResponse) {
        self.router = router
        self.title = title
        self.day = day
    }
    func viewDidLoad() {
        guard let view = view else {
            print("DayScreenAssemble Error")
            return
        }
        view.setCityLabel(city: title)
        if let temp = day.theTemp {
            view.setDegreeLabel(degree: Int(temp))
        }
        view.setWeatherLabel(weather: day.weatherStateName)
        if let min = day.minTemp, let max = day.maxTemp {
            view.setMinMaxDegreeLabel(min: Int(min), max: Int(max))
        }

        if day.applicableDate.isToday {
            view.setTitle("Сегодня")
        } else if day.applicableDate.isTomorrow {
            view.setTitle("Завтра")
        } else if day.applicableDate.isYesterday {
            view.setTitle("Вчера")
        } else {
            view.setTitle(day.applicableDate.weekDay.localizedCapitalized)
        }
        setDescriptionTable(day: day)
    }
    func searchButtonTapped() {
        router.routeToSearchScreen(delegate: self)
    }

    func setDescriptionTable(day: WeatherDayResponse) {
        var sections: [DescriptionSectionModel] = []
        var models: [DescriptionPropertyModel] = []
        models.append(DescriptionPropertyModel(title: "Направление Ветра", description: day.windDirectionCompass))
        models.append(DescriptionPropertyModel(title: "Ветер", description: "\(String(format: "%.1f", day.windSpeed)) м/с"))
        if let humidity = day.humidity {
            models.append(DescriptionPropertyModel(title: "Влажность", description: "\(humidity) %"))
        }
        if let airPressure = day.airPressure {
            models.append(DescriptionPropertyModel(title: "Давление", description: "\(Int(airPressure)) мм рт.cт"))
        }
        if let visibility = day.visibility {
            models.append(DescriptionPropertyModel(title: "Видимость", description: "\(String(format: "%.2f", visibility)) км"))
        }
        sections.append(DescriptionSectionModel(models))
        dataSource.updateForSections(sections)
        view?.update()
    }
    func pushNewCity(cityId: Int, cityName: String) {
        router.routeToNewCity(cityId: cityId, cityName: cityName)
    }
}
