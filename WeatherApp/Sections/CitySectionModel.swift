//
//  CitySectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

protocol CitySectionModelDelegate: class {
  func didTapCall(withPhone phoneNumber: String)
  func didTapText(withEmail email: String)
}

class CitySectionModel: SectionRowsRepresentable {
  var rows: [CellIdentifiable] = []

  weak var delegate: CitySectionModelDelegate?

  init(_ properties: [CityModel]) {
    properties.forEach { property in
      rows.append(CityCellModel(property))
    }
  }
}
