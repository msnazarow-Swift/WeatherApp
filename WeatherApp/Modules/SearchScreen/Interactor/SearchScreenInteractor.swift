//
//  SearchScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import Moya

final class SearchScreenInteractor: SearchScreenInteractorProtocol {
    func searchWithSubstring(_ substring: String, complition: @escaping ([WeatherCityModel]) -> Void) {
        let provider = MoyaProvider<WeatherTarget>()
        provider.request(.getCities(query: substring)) { result in
            switch result {
            case let .success(response):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let cities = try response.map([WeatherCityResponse].self, using: decoder).map { WeatherCityModel($0) }
                    complition(cities)
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
