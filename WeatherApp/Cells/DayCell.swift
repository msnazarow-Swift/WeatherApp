//
//  DayCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
class DayCell: WeatherCell {
  let dayOfWeekLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  let weatherImg: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  let maxTempLabel: UILabel = {
    let label = UILabel()
    return label
  }()
  let minTempLabel: UILabel = {
    let label = UILabel()
    return label
  }()
    override func updateViews() {
        guard let model = model as? DayCellModel else {
            return
        }
      dayOfWeekLabel.text = model.dayOfWeek
//      if let imagePath = model.weatherImg.path {
        weatherImg.image = UIImage(contentsOfFile: model.weatherImg.path)
//              }

      maxTempLabel.text = String(model.maxTemp)
      minTempLabel.text = String(model.minTemp)
    }
}
