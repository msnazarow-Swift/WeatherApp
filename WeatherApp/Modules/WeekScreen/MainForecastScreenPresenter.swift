//
//  MainForecastScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol MainForecastScreenViewOutput: class {
    func viewDidLoad()
    func tableViewDidSelect(row: Int)
    func searchButtonTapped()
    func settingsButtonTapped()
    var dataSource: MainForecastScreenDataSource { get }
}

protocol PresenterPushViewProtocol: class {
    func pushNewCity(cityId: Int, cityName: String)
}

class MainForecastScreenPresenter: MainForecastScreenViewOutput, PresenterPushViewProtocol {
    weak var view: MainForecastScreenViewInput?
    private let router: MainForecastScreenRouterInput
    var interactor: MainForecastScreenInteractorInput?
    var title: String
    var cityId: Int
    var weatherDays: [WeatherDayResponse]?
    var dataSource = MainForecastScreenDataSource()

    init(router: MainForecastScreenRouterInput, cityId: Int, cityName: String) {
        self.router = router
        self.cityId = cityId
        self.title = cityName
    }

    func viewDidLoad() {
        view?.viewWillSetup()
        loadForCity(cityId: cityId)
        view?.setCityLabel(city: title)
    }

    func loadForCity(cityId: Int) {
        var sections: [DaySectionModel] = []
        weatherDays = []
        guard let interactor = interactor else {
            print("MainForecastScreenAssemble error")
            return
        }

        interactor.getImages { images in
            interactor.saveImages(images)
        }
        if StorageService.shared.isWeekMode {
            interactor.getWeekForecast(cityId: cityId) { [weak self] days in
                self?.weatherDays?.append(contentsOf: days.sorted { $0.applicableDate < $1.applicableDate })
                if let models = self?.makeModels() {
                    sections.append(DaySectionModel(models))
                }
                self?.updateView(sections: sections)
                self?.view?.viewDidSetup()
            }
        } else {
            interactor.getNextSixDaysForecast(cityId: cityId) { [weak self] weatherWeek in
                self?.title = weatherWeek.title
                self?.weatherDays = weatherWeek.consolidatedWeather

                interactor.getRestFourDaysForecast(cityId: cityId) { days in
                    self?.weatherDays?.append(contentsOf: days.sorted { $0.applicableDate < $1.applicableDate })
                    if let models = self?.makeModels() {
                        sections.append(DaySectionModel(models))
                    }
                    self?.updateView(sections: sections)
                    self?.view?.viewDidSetup()
                }
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
        if let weatherDays = weatherDays, row < weatherDays.count {
            router.routeToDaySrceen(cityName: title, day: weatherDays[row])
        }
    }

    func searchButtonTapped() {
        router.routeToSearchScreen(delegate: self)
    }
    func settingsButtonTapped() {
        router.routeToSettingsScreen(delegate: self)
    }

    func pushNewCity(cityId: Int, cityName: String) {
        router.routeToNewCity(cityId: cityId, cityName: cityName)
    }
}
