//
//  CitySectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

class CitySectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [CityModel]) {
        properties.forEach { property in
            rows.append(CityCellModel(property))
        }
    }
}
