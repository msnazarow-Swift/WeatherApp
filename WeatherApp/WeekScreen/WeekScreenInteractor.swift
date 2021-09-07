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
  var presenter: WeekScreenInteractorOutput? { get set }
  func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void)
  func getImages(complition: @escaping ([String: Image]) -> Void)
  func saveImages(_ images: [String: Image])
}

protocol WeekScreenInteractorOutput: class {
}
class WeekScreenInteractor: WeekScreenInteractorInput {
  weak var presenter: WeekScreenInteractorOutput?
  let provider = MoyaProvider<WeatherService>()

  func getWeekForecast(cityId: Int, complition: @escaping (WeatherWeek) -> Void) {
    provider.request(.getWeek(woeid: cityId)) { result in
      switch result {
      case .success(let response):
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategyFormatters = [DateFormatter.iso8601Full, DateFormatter.yyyyMMdd]
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
          let weatherWeek = try response.map(WeatherWeek.self, using: decoder)
          complition(weatherWeek)
        } catch {
          do {
            let notFound = try response.map(NotFound.self, using: decoder)
            print("Error: cityId = \(cityId) not found")
          } catch {
            print(error)
          }
        }
      case .failure(let error):
        print(error)
      }
    }
  }

  func getImages(complition: @escaping ([String: Image]) -> Void) {
    var images: [String: Image] = [:]
    let queue = DispatchQueue(label: "imagesDispatchQueue")
    for abbr in abbreviations {
      //      provider.request(<#T##target: WeatherService##WeatherService#>, callbackQueue: <#T##DispatchQueue?#>, progress: <#T##ProgressBlock?##ProgressBlock?##(ProgressResponse) -> Void#>, completion: <#T##Completion##Completion##(Result<Response, MoyaError>) -> Void#>)
      provider.request(.getImage(abbreviation: abbr)) { result in
        switch result {
        case .success(let response):
          queue.sync {
            do {
              images[abbr] = try response.mapImage()
            } catch let error {
              print(error)
            }
          }
        case .failure(let error):
          print(error)
        }
        if abbr == abbreviations.last {
          // TODO: - Иногда грузятся не все картинки
          complition(images)
        }
      }
    }
  }

  func saveImages(_ images: [String: Image]) {
    StorageService.shared.saveImages(images)
  }
}
