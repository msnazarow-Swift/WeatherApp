//
//  PropertyCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct WeatherProperty {
  let title: String
  let description: String
}

class PropertyCellModel: WeatherCellModel {
    override var cellIdentifier: String {
        return "PropertyCell"
    }

    var title: String
    var description: String
  // TODO: - Why var ? 
    init(_ property: WeatherProperty) {
      title = property.title
      description = property.description
    }
}
