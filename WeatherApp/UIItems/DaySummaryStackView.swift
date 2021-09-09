//
//  DaySummaryStackView.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit

class DaySummaryStackView: UIStackView {
  let cityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Medium", size: 25 * fontTrans)
    return (label)
  }()

  let weatherLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12 * fontTrans)
    return (label)
  }()

  let degreeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Light", size: 60 * fontTrans)
    return (label)
  }()

  let minMaxLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12 * fontTrans)
    return (label)
  }()
  override init(frame: CGRect) {
    super.init(frame: frame)
    addArrangedSubview(cityLabel)
    addArrangedSubview(weatherLabel)
    addArrangedSubview(degreeLabel)
    addArrangedSubview(minMaxLabel)
//    cityLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
    axis = .vertical
    spacing = 5
    alignment = .center
  }

  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
