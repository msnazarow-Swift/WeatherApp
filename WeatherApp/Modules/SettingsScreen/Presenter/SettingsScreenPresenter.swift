//
//  SettingsScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class SettingsScreenPresenter: SettingsScreenPresenterProtocol {
    weak var view: SettingsScreenViewProtocol?
    weak var delegate: PresenterUpdateProtocol?
    private var isWeekMode: Bool
    private let router: SettingsScreenRouterProtocol
    private var settingsStorageService: SettingsStorageServiceProtocol

    init(router: SettingsScreenRouterProtocol, settingsStorageService: SettingsStorageServiceProtocol, delegate: PresenterUpdateProtocol?) {
        self.router = router
        self.settingsStorageService = settingsStorageService
        isWeekMode = settingsStorageService.isWeekMode
        self.delegate = delegate
    }

    func viewDidLoad() {
        view?.setWeekMode(isWeekMode)
    }

    func switcherValueChanged(_ isOn: Bool) {
        isWeekMode = isOn
        settingsStorageService.isWeekMode = isWeekMode
    }

    func closeView() {
        delegate?.updateView()
        router.dismiss()
    }
}
