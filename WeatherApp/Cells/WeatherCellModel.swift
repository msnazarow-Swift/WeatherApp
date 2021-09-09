//
//  WeatherCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

extension CellIdentifiable {
    var automaticHeight: Float { return -1.0 }

    var cellIdentifier: String { return "" }

    var cellHeight: Float { return automaticHeight }
}

class WeatherCell: UITableViewCell, ModelRepresentable {
    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {}
}
