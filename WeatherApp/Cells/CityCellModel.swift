//
//  CityCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct CityModel {
  let title: String
}

class CityCellModel: WeatherCellModel {
  let title: String

  override var cellIdentifier: String {
    return "CityCell"
  }

  init(_ property: CityModel) {
    title = property.title
  }
}
