//
//  GlobalVars.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import UIKit
var verticalTranslation = UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.height / 667.0 : UIScreen.main.bounds.width / 375.0
var horisontalTranslation = UIDevice.current.orientation.isPortrait ? UIScreen.main.bounds.width / 375.0 : UIScreen.main.bounds.height / 667.0
let moscowCityId = 2_122_265
