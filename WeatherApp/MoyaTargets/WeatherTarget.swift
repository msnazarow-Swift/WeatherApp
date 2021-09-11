//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 03.09.2021.
//

import Foundation
import Moya

enum WeatherTarget {
    case getImage(abbreviation: String)
    case getCities(query: String)
    case getWeek(woeid: Int)
    case getDay(woeid: Int, date: Date)
}

// MARK: - TargetType Protocol Implementation

extension WeatherTarget: TargetType {
    var baseURL: URL { return URL(string: "https://www.metaweather.com")! }

    var path: String {
        switch self {
        case let .getImage(abbreviation):
            return "/static/img/weather/ico/\(abbreviation).ico"
        case let .getWeek(woeid):
            return "/api/location/\(woeid)/"
        case let .getDay(woeid, date):
            return "/api/location/\(woeid)/\(date.dateSlashString)/"
        case .getCities:
            return "/api/location/search/"
        }
    }

    var method: Moya.Method { return .get }

    var task: Task {
        switch self {
        case let .getCities(query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var sampleData: Data { return Data() }

    var headers: [String: String]? { return ["Content-type": "application/json"] }
}

// MARK: - Helpers

private extension String {
    var urlEscaped: String { return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! }

    var utf8Encoded: Data { return data(using: .utf8)! }
}
