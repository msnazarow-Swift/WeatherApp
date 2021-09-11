//
//  WeatherWeek.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherWeekResponse: Codable {
    let consolidatedWeather: [WeatherDayResponse]
    let lattLong: String
    let locationType: String
    let parent: WeatherCityResponse
    let sources: [WeatherSourceResponse]
    let sunRise: Date
    let sunSet: Date
    let time: Date
    let timezone: String
    let title: String
    let woeid: Int
}
