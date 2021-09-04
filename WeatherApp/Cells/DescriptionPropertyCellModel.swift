//
//  PropertyCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct DescriptionProperty {
  let title: String
  let description: String
}

class DescriptionPropertyCellModel: WeatherCellModel {
    override var cellIdentifier: String {
        return "DescriptionPropertyCell"
    }

    var title: String
    var description: String
  // TODO: - Why var ? 
    init(_ property: DescriptionProperty) {
      title = property.title
      description = property.description
    }
}
