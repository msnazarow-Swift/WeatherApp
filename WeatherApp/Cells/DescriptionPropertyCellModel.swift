//
//  DescriptionPropertyCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct DescriptionPropertyModel {
  let title: String
  let description: String
}

class DescriptionPropertyCellModel: WeatherCellModel {
  let title: String
  let description: String
  override var cellIdentifier: String {
    return "DescriptionPropertyCell"
  }
  override var cellHeight: Float {
    67
  }
  init(_ property: DescriptionPropertyModel) {
    title = property.title
    description = property.description
  }
}
