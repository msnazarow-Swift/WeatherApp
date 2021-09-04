//
//  WeatherWeek.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherWeek: Codable {
  let consolidatedWeather: [WeatherDay]
  let lattLong: String
  let locationType: String
  let parent: WeatherCity
  let sources: [WeatherSource]
  let sunRise: Date
  let sunSet: Date
  let time: Date
  let timezone: String
  let title: String
  let woeid: Int
}
