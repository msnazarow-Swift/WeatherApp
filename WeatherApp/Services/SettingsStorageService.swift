//
//  SettingsStorageService.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 13.09.2021.
//

import Foundation

final class SettingsStorageService: SettingsStorageServiceProtocol {
    var isWeekMode: Bool {
        get {
            UserDefaults.standard.bool(forKey: "mode")
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "mode")
        }
    }
}
