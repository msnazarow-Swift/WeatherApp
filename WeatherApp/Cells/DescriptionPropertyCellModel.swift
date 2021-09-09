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

struct DescriptionPropertyCellModel: CellIdentifiable {
  let title: String
  let description: String
  var cellIdentifier: String {
    return "DescriptionPropertyCell"
  }
  var cellHeight: Float {
    67
  }
  init(_ property: DescriptionPropertyModel) {
    title = property.title
    description = property.description
  }
}
