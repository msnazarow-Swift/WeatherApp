//
//  WeatherCity.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherCity: Codable {
  let lattLong: String
  let locationType: String
  let title: String
  let woeid: Int
}

 struct City {
  let lattLong: [Double]
  let locationType: String
  let title: String
  let woeid: Int
  init(_ weatherCity: WeatherCity) {
    self.locationType = weatherCity.locationType
    self.title = weatherCity.title
    self.woeid = weatherCity.woeid
    self.lattLong = weatherCity.lattLong.split(separator: ",").map { Double($0)! }
  }
 }
