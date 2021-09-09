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
    func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void)
    func getMaxForecast(cityId: Int, complition: @escaping ([WeatherDay]) -> Void)
    func getImages(complition: @escaping ([String: Image]) -> Void)
    func saveImages(_ images: [String: Image])
}

protocol WeekScreenInteractorOutput: class {}

class WeekScreenInteractor: WeekScreenInteractorInput {
    weak var presenter: WeekScreenInteractorOutput?
    let provider = MoyaProvider<WeatherService>()

    func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void) {
        provider.request(.getWeek(woeid: cityId)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let weatherWeek = try response.map(WeatherWeek.self, using: decoder)
                    complition(weatherWeek)
                } catch {
                    do {
                        _ = try response.map(NotFound.self, using: decoder)
                        print("Error: cityId = \(cityId) not found")
                    } catch {
                        print(error)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    func getMaxForecast(cityId: Int, complition: @escaping ([WeatherDay]) -> Void) {
        var day = Date()
        day = Calendar.current.date(byAdding: .day, value: 6, to: day)!
        var weatherDays: [WeatherDay] = []
        let group = DispatchGroup()
        for _ in 0 ... 3 {
            group.enter()
            provider.request(.getDay(woeid: cityId, date: day)) { result in
                switch result {
                case let .success(response):
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        if let day = try response.map([WeatherDay].self, using: decoder).first {
                            weatherDays.append(day)
                        }
                    } catch {
                        do {
                            _ = try response.map(NotFound.self, using: decoder)
                            print("Error: cityId = \(cityId) not found")
                        } catch {
                            print(error)
                        }
                    }
                case let .failure(error):
                    print(error)
                }
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
            provider.request(.getImage(abbreviation: abbr)) { result in
                switch result {
                case let .success(response):
                    do {
                        images[abbr] = try response.mapImage()
                    } catch {
                        print(error)
                    }
                case let .failure(error):
                    print(error)
                }
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
