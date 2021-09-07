//
//  CityCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class CityCell: WeatherCell {
  static let identifier = "CityCell"
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
  }
  required init?(coder: NSCoder) {
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
    textLabel.adjustsFontSizeToFitWidth = true
    textLabel.font = UIFont(name: "Roboto-Regular", size: 16 * fontTrans)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }
}
