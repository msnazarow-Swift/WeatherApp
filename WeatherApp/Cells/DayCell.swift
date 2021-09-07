//
//  DayCell.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
class DayCell: WeatherCell {
  static let identifier = "DayCell"
  let dayOfWeekLabel: UILabel = {
    let label = UILabel()
    //    label.frame = CGRect(x: 0, y: 0, width: 100 * fontTrans, height: 16 * fontTrans)
    label.font = UIFont(name: "Roboto-Regular", size: 14 * fontTrans)
    return label
  }()
  let weatherImg: UIImageView = {
    let imageView = UIImageView()
//    imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    return imageView
  }()
  let maxTempLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = UIFont(name: "Roboto-Medium", size: 14 * fontTrans)
    return label
  }()
  let minTempLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .right
    label.font = UIFont(name: "Roboto-Regular", size: 14 * fontTrans)
    return label
  }()
  lazy var vstack: UIStackView = {
    let view = UIView()
    view.addSubview(weatherImg)
    let stack = UIStackView(arrangedSubviews: [dayOfWeekLabel, view, maxTempLabel, minTempLabel])
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    stack.setCustomSpacing(-50, after: maxTempLabel)
    weatherImg.contentMode = .scaleAspectFit
    weatherImg.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(24 * fontTrans)
      make.width.equalTo(24 * fontTrans)
    }
//    stack.translatesAutoresizingMaskIntoConstraints = false

    //

    //    stack.spacing = 40
    //    stack.setCustomSpacing(93.0 * fontTrans, after: weatherImg)
    //    stack.setCustomSpacing(25.0 * fontTrans, after: maxTempLabel)
    //    dayOfWeekLabel.contentMode = .scaleToFill

    //    weatherImg.clipsToBounds = true
    //    maxTempLabel.contentMode = .scaleToFill
    //    minTempLabel.contentMode = .scaleToFill
    //    weatherImg.snp.makeConstraints { make in
    //      make.height.equalTo(24)
    //      make.width.equalTo(24)
    //    }
    //    stack.alignment = .fill
    return stack
  }()
  override func updateViews() {
    guard let model = model as? DayCellModel else {
      return
    }
    dayOfWeekLabel.text = model.dayOfWeek
    // TODO: - Ячейка обращается напрямую к сервису
    weatherImg.image = StorageService.shared.getImageForKey(model.weatherImg)
    //    weatherImg.image
    maxTempLabel.text = String(model.maxTemp)
    minTempLabel.text = String(model.minTemp)
    contentView.addSubview(vstack)
    vstack.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    //      addSubview(vstack)
  }
  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 14))
  }
}
