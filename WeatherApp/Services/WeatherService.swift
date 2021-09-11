//
//  WeatherService.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 11.09.2021.
//

import Moya

class WeatherService {
    let provider = MoyaProvider<WeatherTarget>()
    enum ResponceError: Error {
        case noResponce
    }
    func getWeekForCity(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void) {
        provider.request(.getWeek(woeid: cityId)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let weatherWeek = try response.map(WeatherWeekResponse.self, using: decoder)
                    complition(weatherWeek)
                } catch {
                    do {
                        _ = try response.map(NotFoundResponse.self, using: decoder)
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

    func getDayForCity(cityId: Int, day: Date, complition: @escaping (Result<WeatherDayResponse, Error>) -> Void) {
        provider.request(.getDay(woeid: cityId, date: day)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    if let day = try response.map([WeatherDayResponse].self, using: decoder).first {
                        complition(.success(day))
                    } else {
                        complition(.failure(ResponceError.noResponce))
                    }
                } catch {
                    do {
                        _ = try response.map(NotFoundResponse.self, using: decoder)
                        print("Error: cityId = \(cityId) not found")
                        complition(.failure(error))
                    } catch {
                        complition(.failure(error))
                    }
                }
            case let .failure(error):
                complition(.failure(error))
            }
        }
    }
    func getImage(imageAbbreviation: String, complition: @escaping (Image) -> Void) {
        provider.request(.getImage(abbreviation: imageAbbreviation)) { result in
            switch result {
            case let .success(response):
                do {
                    complition(try response.mapImage())
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}