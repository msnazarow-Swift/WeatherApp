//
//  WeatherSectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

protocol DescriptionSectionModelDelegate: class {
    func didTapCall(withPhone phoneNumber: String)
    func didTapText(withEmail email: String)
}

class DescriptionSectionModel: SectionRowsRepresentable {
  var rows: [CellIdentifiable]

     weak var delegate: DescriptionSectionModelDelegate?

     init(_ property: DescriptionProperty) {
         rows = [CellIdentifiable]()

         rows.append(DescriptionPropertyCellModel(property))
     }
}