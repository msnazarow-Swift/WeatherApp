//
//  SettingsScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 12.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class SettingsScreenPresenter: SettingsScreenPresenterProtocol {
    weak var view: SettingsScreenViewProtocol?

    weak var delegate: PresenterUpdateProtocol?

    private var isWeekMode: Bool

    private let router: SettingsScreenRouterProtocol

    init(router: SettingsScreenRouterProtocol, delegate: PresenterUpdateProtocol?) {
        self.router = router
        isWeekMode = StorageService.shared.isWeekMode
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
        delegate?.updateView()
        router.dismiss()
    }
}
