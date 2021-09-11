//
//  WeatherDay.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation
struct WeatherDayResponse: Codable {
    let airPressure: Double?
    let applicableDate: Date
    let created: Date
    let humidity: Int?
    let id: Int
    let maxTemp: Double?
    let minTemp: Double?
    let predictability: Int
    let theTemp: Double?
    let visibility: Double?
    let weatherStateAbbr: String
    let weatherStateName: String
    let windDirection: Double
    let windDirectionCompass: String
    let windSpeed: Double
}
