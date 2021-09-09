//
//  CityCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct CityModel {
    let title: String
}

class CityCellModel: CellIdentifiable {
    let title: String

    var cellIdentifier: String { return "CityCell" }

    init(_ property: CityModel) {
        title = property.title
    }
}
