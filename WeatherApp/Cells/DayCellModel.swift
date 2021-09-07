//
//  DayCellModel.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation

struct DayModel {
  var dayOfWeek: String
  var weatherImg: String
  var maxTemp: Int
  var minTemp: Int
}

class DayCellModel: WeatherCellModel {
  override var cellIdentifier: String {
    return "DayCell"
  }
  override var cellHeight: Float {
    Float(30 * fontTrans)
  }
  let dayOfWeek: String
  let weatherImg: String
  let maxTemp: Int
  let minTemp: Int

  init(_ day: DayModel) {
    dayOfWeek = day.dayOfWeek
    weatherImg = day.weatherImg
    maxTemp = day.maxTemp
    minTemp = day.minTemp
  }
}
