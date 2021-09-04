//
//  WeatherSource.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherSource: Codable {
  let crawlRate: Int
  let slug: String
  let title: String
  let url: URL
}
