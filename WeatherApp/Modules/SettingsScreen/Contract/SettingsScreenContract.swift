//
//  SettingsScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Foundation

protocol SettingsScreenViewProtocol: AnyObject {
    func setWeekMode(_ isWeekMode: Bool)
}

protocol SettingsScreenPresenterProtocol: AnyObject {
    func switcherValueChanged(_ isOn: Bool)
    func viewDidLoad()
    func closeView()
}

protocol SettingsScreenRouterProtocol: AnyObject {
    func dismiss()
}
