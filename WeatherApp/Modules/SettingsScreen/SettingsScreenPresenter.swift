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

    weak var delegate: MainForecastScreenViewOutput?

    private var isWeekMode: Bool

    private let router: SettingsScreenRouter

    init(router: SettingsScreenRouter, delegate: MainForecastScreenViewOutput?) {
        self.router = router
        self.isWeekMode = StorageService.shared.isWeekMode
        self.delegate = delegate
    }

    func viewDidLoad() {
        view?.setWeekMode(isWeekMode)
    }
    func switcherValueChanged(_ isOn: Bool) {
        isWeekMode = isOn
        StorageService.shared.isWeekMode = isWeekMode
    }
    func closeView() {
        router.routeToForecastScreen(delegate: delegate)
    }
}
