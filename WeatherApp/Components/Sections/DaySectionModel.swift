//
//  DaySectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

class DaySectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [DayModel]) {
        properties.forEach { property in
            rows.append(DayCellModel(property))
        }
    }
}
