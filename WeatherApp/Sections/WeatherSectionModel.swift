//
//  WeatherSectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

protocol WeatherSectionModelDelegate: class {
    func didTapCall(withPhone phoneNumber: String)
    func didTapText(withEmail email: String)
}

class WeatherSectionModel: SectionRowsRepresentable {
  var rows: [CellIdentifiable]

     weak var delegate: WeatherSectionModelDelegate?

     init(_ property: WeatherProperty) {
         rows = [CellIdentifiable]()

         rows.append(PropertyCellModel(property))
     }
}
