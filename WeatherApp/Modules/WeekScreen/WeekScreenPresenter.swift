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
    func settingsButtonTapped()
    var dataSource: WeekScreenDataSource { get }
}

class WeekScreenPresenter: WeekScreenViewOutput {
    weak var view: WeekScreenViewInput?
    private let router: WeekScreenRouterInput
    var interactor: WeekScreenInteractorInput?
    var title: String?
    var cityId: Int
    var isWeekMode: Bool
    var weatherDays: [WeatherDayResponse]?
    var dataSource = WeekScreenDataSource()

    init(router: WeekScreenRouterInput, cityId: Int, isWeekMode: Bool) {
        self.router = router
        self.cityId = cityId
        self.isWeekMode = isWeekMode
    }

    func viewDidLoad() {
        loadForCity(cityId: cityId)
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
                self?.view?.viewDidSetup()
            }
        }
    }

	private func makeModels() -> [DayModel] {
        var models: [DayModel] = []

        self.weatherDays?.forEach { day in
            let model = DayModel(
                dayOfWeek: day.applicableDate.weekDay.localizedCapitalized,
                weatherImg: day.weatherStateAbbr,
                maxTemp: Int(day.maxTemp ?? 0),
                minTemp: Int(day.minTemp ?? 0)
            )
            models.append(model)
        }
        return models
    }

    private func updateView(sections: [DaySectionModel]) {
        guard let view = view else { return }

        dataSource.updateForSections(sections)
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
        view.update()
    }

    func tableViewDidSelect(row: Int) {
        if let title = title, let weatherDays = weatherDays {
            router.routeToDaySrceen(cityName: title, day: weatherDays[row], isWeekMode: isWeekMode)
        }
    }

    func searchButtonTapped() {
        router.routeToSearchScreen(isWeekMode: isWeekMode)
    }
    func settingsButtonTapped() {
        router.routeToSettingsScreen(isWeekMode: isWeekMode)
    }
}
