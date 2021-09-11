//
//  WeekScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

protocol WeekScreenInteractorInput: class {
    func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void)
    func getMaxForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void)
    func getImages(complition: @escaping ([String: Image]) -> Void)
    func saveImages(_ images: [String: Image])
}

protocol WeekScreenInteractorOutput: class {}

class WeekScreenInteractor: WeekScreenInteractorInput {
    private let weatherService = WeatherService()

    func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void) {
        weatherService.getWeekForCity(cityId: cityId, complition: complition)
    }

    func getMaxForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void) {
        var day = Date()
        day = Calendar.current.date(byAdding: .day, value: 6, to: day)!
        var weatherDays: [WeatherDayResponse] = []
        let group = DispatchGroup()
        for _ in 0 ... 3 {
            group.enter()
            weatherService.getDayForCity(cityId: cityId, day: day) {  result in
                try? weatherDays.append(result.get())
                group.leave()
            }
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        }
        group.notify(queue: .main) {
            complition(weatherDays)
        }
    }

    func getImages(complition: @escaping ([String: Image]) -> Void) {
        var images: [String: Image] = [:]
        let group = DispatchGroup()
        for abbr in abbreviations {
            group.enter()
            weatherService.getImage(imageAbbreviation: abbr) { result in
                try? images[abbr] = result.get()
                group.leave()
            }
        }
        group.notify(queue: .main) {
            complition(images)
        }
    }

    func saveImages(_ images: [String: Image]) {
        StorageService.shared.saveImages(images)
    }
}
