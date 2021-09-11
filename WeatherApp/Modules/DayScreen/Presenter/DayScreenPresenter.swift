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
}

class DayScreenPresenter: DayScreenViewOutput {
    weak var view: DayScreenViewInput?

    private let router: DayScreenRouter

    var interactor: DayScreenInteractorInput?

    var dataSource = DayScreenDataSource()

    init(router: DayScreenRouter, day: WeatherDayResponse) {
        self.router = router
        setDescriptionTable(day: day)
    }

    func searchButtonTapped() {
        router.routeToSearchScreen()
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
}
