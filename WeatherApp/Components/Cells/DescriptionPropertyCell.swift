//
//  DescriptionPropertyCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

final class DescriptionPropertyCell: WeatherCell {
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
        textLabel.font = .regular(11 * verticalTranslation)
        textLabel.textColor = .whiteHalfAlpha
        detailTextLabel.text = model.description
        detailTextLabel.font = .regular(30 * verticalTranslation)
    }
}
