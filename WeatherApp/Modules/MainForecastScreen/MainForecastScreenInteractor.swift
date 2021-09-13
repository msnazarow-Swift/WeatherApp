//
//  MainForecastScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

class MainForecastScreenInteractor: MainForecastScreenInteractorProtocol {
    private let weatherService: WeatherServiceProtocol
    private let imageStorageService: ImageStorageServiceProtocol

    init(weatherService: WeatherServiceProtocol, storageService: ImageStorageServiceProtocol) {
        self.weatherService = weatherService
        self.imageStorageService = storageService
    }

    func getNextSixDaysForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void) {
        weatherService.getWeekForCity(cityId: cityId, complition: complition)
    }

    func getWeekForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void) {
        var day = Date.MondeyOfThisWeek!
        var weatherDays: [WeatherDayResponse] = []
        let group = DispatchGroup()
        for _ in 0 ... 6 {
            group.enter()
            weatherService.getDayForCity(cityId: cityId, day: day) { result in
                try? weatherDays.append(result.get())
                group.leave()
            }
            day = day.byAddingDay(1)
        }
        group.notify(queue: .main) {
            complition(weatherDays)
        }
    }

    func getRestFourDaysForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void) {
        var day = Date().byAddingDay(6)
        var weatherDays: [WeatherDayResponse] = []
        let group = DispatchGroup()
        for _ in 0 ... 3 {
            group.enter()
            weatherService.getDayForCity(cityId: cityId, day: day) { result in
                try? weatherDays.append(result.get())
                group.leave()
            }
            day = day.byAddingDay(1)
        }
        group.notify(queue: .main) {
            complition(weatherDays)
        }
    }

    func getImages(complition: @escaping ([String: Image]) -> Void) {
        var images: [String: Image] = [:]
        let group = DispatchGroup()
        for abbr in imageStorageService.abbreviations {
            if let image = imageStorageService.getImage(for: abbr) {
                images[abbr] = image
            } else {
                group.enter()
                weatherService.getImage(for: abbr) { result in
                    try? images[abbr] = result.get()
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            complition(images)
        }
    }

    func getImage(for abbr: String) -> UIImage? {
        return imageStorageService.getImage(for: abbr)
    }

    func saveImages(_ images: [String: Image]) {
        imageStorageService.saveImages(images)
    }
}

/*          ---         Что если закачивать не сразу все фотки, а только те которые нужны? ---
    func getImage(for abbr: String, complition: @escaping (Image?) -> Void) {
        if let image = storageService.getImageForKey(abbr) {
            complition(image)
        } else {
            weatherService.getImage(for: abbr) { [ weak self] result in
                let image = try? result.get()
                self?.storageService.saveImage(for: abbr, image: image)
                complition(image)
            }
        }
    }

*/
