//
//  GlobalVars.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
// var verticalTranslation: CGFloat!
// horisontalTranslation: CGFloat!
var verticalTranslation = UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.height / 667.0 : UIScreen.main.bounds.width / 375.0
var horisontalTranslation = UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.width / 375.0 : UIScreen.main.bounds.height / 667.0
let abbreviations = ["sn", "sl", "h", "t", "hr", "lr", "s", "hc", "lc", "c"]
let moscowCityId = 2122265
