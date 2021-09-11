//
//  UIFont+Ext.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 11.09.2021.
//

import UIKit

extension UIFont {
    static func medium(_ size: CGFloat) -> UIFont? {
        UIFont(name: "Roboto-Medium", size: size)
    }
    static func regular(_ size: CGFloat) -> UIFont? {
        UIFont(name: "Roboto-Regular", size: size)
    }
    static func light(_ size: CGFloat) -> UIFont? {
        UIFont(name: "Roboto-Light", size: size)
    }
}
