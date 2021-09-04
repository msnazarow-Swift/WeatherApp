//
//  PropertyCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class DescriptionPropertyCell: WeatherCell {
  static let identifier = "DescriptionPropertyCell"
  override func updateViews() {
    guard let model = model as? DescriptionPropertyCellModel else { return }
    textLabel?.text = model.title
    detailTextLabel?.text = model.description
    detailTextLabel?.font = UIFont(name: "Roboto-Regular", size: 30 * fontTrans)
    textLabel?.font = UIFont(name: "Roboto-Regular", size: 11 * fontTrans)
    textLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
  }

  override func layoutSubviews() {
      super.layoutSubviews()

      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
  }
}