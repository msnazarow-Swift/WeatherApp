//
//  SettingsScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class SettingsScreenPresenter: SettingsScreenViewOutput {
    weak var view: SettingsScreenViewInput?

    private let isWeekMode: Bool

    private let router: SettingsScreenRouter

    init(router: SettingsScreenRouter, isWeekMode: Bool) {
        self.router = router
        self.isWeekMode = isWeekMode
    }

    func viewDidLoad() {
        view?.setWeekMode(isWeekMode)
    }
    func switcherValueChanged(_ isOn: Bool) {
    }
}
