//
//  WeekScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol WeekScreenViewOutput: class {
    func loadForCity(cityId: Int)
    func tableViewDidSelect(row: Int)
    func searchButtonTapped()
}

class WeekScreenPresenter: WeekScreenViewOutput {
    weak var view: WeekScreenViewInput?
    private let router: WeekScreenRouterInput
    var interactor: WeekScreenInteractorInput?
    var title: String?
    var weatherDays: [WeatherDay]?
    init(router: WeekScreenRouterInput) {
        self.router = router
    }

    func loadForCity(cityId: Int) {
        guard let interactor = interactor else {
            print("WeekScreenAssemble error")
            return
        }

        interactor.getImages { images in
            interactor.saveImages(images)
        }

        interactor.getWeekForecast(cityId: cityId) { [weak self] weatherWeek in
            self?.title = weatherWeek.title
            self?.weatherDays = weatherWeek.consolidatedWeather
            var sections: [DaySectionModel] = []

            interactor.getMaxForecast(cityId: cityId) { days in
                self?.weatherDays?.append(contentsOf: days.sorted { $0.applicableDate < $1.applicableDate })
                if let models = self?.makeModels() {
                    sections.append(DaySectionModel(models))
                }
                self?.updateView(sections: sections)
            }
        }
    }

	private
    func makeModels() -> [DayModel] {
        var models: [DayModel] = []
        let weekFormatter = DateFormatter()
        weekFormatter.dateFormat = "EEEE"

        self.weatherDays?.forEach { day in
            let model = DayModel(
                dayOfWeek: weekFormatter.string(from: day.applicableDate),
                weatherImg: day.weatherStateAbbr,
                maxTemp: Int(day.maxTemp ?? 0),
                minTemp: Int(day.minTemp ?? 0)
            )
            models.append(model)
        }
        return models
    }

    private
    func updateView(sections: [DaySectionModel]) {
        guard let view = view else { return }

        view.updateForSections(sections)
        if let title = self.title {
            view.setCityLabel(city: title)
        }
        guard let day = weatherDays?.first else { return }
        if let temp = day.theTemp {
            view.setDegreeLabel(degree: Int(temp))
        }
        view.setWeatherLabel(weather: day.weatherStateName)
        if let minTemp = day.minTemp, let maxTemp = day.maxTemp {
            view.setMinMaxDegreeLabel(min: Int(minTemp), max: Int(maxTemp))
        }
    }

    func tableViewDidSelect(row: Int) {
        if let title = title, let weatherDays = weatherDays {
            router.routeToDaySrceen(title: title, day: weatherDays[row])
        }
    }

    func searchButtonTapped() {
        router.routeToSearchScreen()
    }
}
