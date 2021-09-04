//
//  DaySectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

protocol DaySectionModelDelegate: class {
    func didTapCall(withPhone phoneNumber: String)
    func didTapText(withEmail email: String)
}

class DaySectionModel: SectionRowsRepresentable {
  var rows: [CellIdentifiable]

     weak var delegate: DaySectionModelDelegate?

     init(_ property: DayModel) {
         rows = [CellIdentifiable]()

         rows.append(DayCellModel(property))
     }
}