//
//  SearchTextField.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 07.09.2021.
//

import UIKit

class SearchTextField: DesignableUITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    // MARK: - Пришлось ставить SF чтоб найти лупу
    leftImage = UIImage(systemName: "magnifyingglass")!
    leftPadding = 7
    rightPadding = 7
    layer.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1).cgColor
    layer.cornerRadius = 8
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
