//
//  CityCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class CityCell: WeatherCell {
    static let identifier = "CityCell"
    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? CityCellModel,
              let textLabel = textLabel
        else {
            print("DescriptionPropertyCell Error")
            return
        }
        textLabel.text = model.title.capitalized
        textLabel.font = UIFont(name: "Roboto-Regular", size: 16 * fontTrans)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
