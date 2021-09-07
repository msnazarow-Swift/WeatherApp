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
  override var cellIdentifier: String {
    return "CityCell"
  }

  var title: String
  // TODO: - Why var ? 
  init(_ property: DescriptionPropertyModel) {
    title = property.title
  }
}
