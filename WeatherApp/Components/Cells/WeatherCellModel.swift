//
//  WeatherCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class WeatherCell: UITableViewCell, ModelRepresentable {
    weak var presenter: MainForecastScreenPresenterToCellsProtocol?

    var model: CellIdentifiable? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {}
}
