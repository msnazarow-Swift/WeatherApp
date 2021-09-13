//
//  WeatherSectionModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

final class DescriptionSectionModel: SectionRowsRepresentable {
    var rows: [CellIdentifiable] = []

    init(_ properties: [DescriptionPropertyModel]) {
        properties.forEach { property in
            rows.append(DescriptionPropertyCellModel(property))
        }
    }
}
