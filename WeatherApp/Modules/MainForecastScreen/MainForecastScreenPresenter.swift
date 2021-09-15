//
//  MainForecastScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class MainForecastScreenPresenter {
    // MARK: - Properties

    weak var view: MainForecastScreenViewProtocol?
    var interactor: MainForecastScreenInteractorProtocol?
    let dataSource: MainForecastScreenDataSourceProtocol
    private let router: MainForecastScreenRouterProtocol

    private var title: String
    private var cityId: Int
    private var weatherDays: [WeatherDayResponse]?
    private let settingsStorageService: SettingsStorageServiceProtocol

    // MARK: - Init

    init(router: MainForecastScreenRouterProtocol,
         cityId: Int,
         cityName: String,
         dataSource: MainForecastScreenDataSourceProtocol,
         settingsStorageService: SettingsStorageServiceProtocol) {
        self.router = router
        self.cityId = cityId
        title = cityName
        self.dataSource = dataSource
        self.settingsStorageService = settingsStorageService
    }

    func viewDidLoad() {
        guard interactor != nil else {
            print("MainForecastScreenPresenter Assemble Error")
            return
        }
        loadForCity(cityId: cityId)
        view?.setCityLabel(city: title)
    }

    private func loadForCity(cityId: Int) {
        weatherDays = []
        interactor?.getImages { [weak self] images in
            self?.interactor?.saveImages(images)
        }
        if settingsStorageService.isWeekMode {
            loadWeek(for: cityId)
        } else {
            loadForecast(for: cityId)
        }
    }

    private func loadWeek(for cityId: Int) {
        var sections: [DaySectionModel] = []
        interactor?.getWeekForecast(cityId: cityId) { [weak self] days in
            self?.weatherDays?.append(contentsOf: days.sorted { $0.applicableDate < $1.applicableDate })
            if let models = self?.makeModels() {
                sections.append(DaySectionModel(models))
            }
            self?.updateView(sections: sections)
            self?.view?.viewDidSetup()
        }
    }

    private func loadForecast(for cityId: Int) {
        var sections: [DaySectionModel] = []
        interactor?.getNextSixDaysForecast(cityId: cityId) { [weak self] weatherWeek in
            self?.title = weatherWeek.title
            self?.weatherDays = weatherWeek.consolidatedWeather

            self?.interactor?.getRestFourDaysForecast(cityId: cityId) { days in
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

        weatherDays?.forEach { day in
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
        view.reloadTableViewData()
    }
}
extension MainForecastScreenPresenter: MainForecastScreenPresenterProtocol {
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
}

extension MainForecastScreenPresenter: PresenterPushViewProtocol {
    func pushNewCity(cityId: Int, cityName: String) {
        router.routeToNewCity(cityId: cityId, cityName: cityName)
    }
}

extension MainForecastScreenPresenter: PresenterUpdateProtocol {
    func updateView() {
        view?.updateMode()
    }
}

extension MainForecastScreenPresenter: MainForecastScreenPresenterToCellsProtocol {
    func getImage(for abbr: String) -> UIImage? {
        return interactor?.getImage(for: abbr)
    }
}
