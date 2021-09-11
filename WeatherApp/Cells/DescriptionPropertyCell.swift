//
//  DescriptionPropertyCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class DescriptionPropertyCell: WeatherCell {
    static let identifier = "DescriptionPropertyCell"

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViews() {
        guard let model = model as? DescriptionPropertyCellModel,
              let textLabel = textLabel,
              let detailTextLabel = detailTextLabel
        else {
            print("DescriptionPropertyCell Error")
            return
        }
        textLabel.text = model.title.uppercased()
        textLabel.font = UIFont(name: "Roboto-Regular", size: 11 * fontTrans)
        textLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        detailTextLabel.text = model.description
        detailTextLabel.font = UIFont(name: "Roboto-Regular", size: 30 * fontTrans)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
