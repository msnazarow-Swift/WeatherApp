//
//  PropertyCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class PropertyCell: WeatherCell {
  static let identifier = "PropertyTableViewCell"
  override func updateViews() {
    guard let model = model as? PropertyCellModel else { return }
    textLabel?.text = model.title
    detailTextLabel?.text = model.description
  }
}
