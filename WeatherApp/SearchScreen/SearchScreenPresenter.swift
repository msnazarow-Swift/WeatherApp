//
//  SearchScreenPresenter.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation


protocol SearchScreenViewOutput: class {
}

class SearchScreenPresenter: SearchScreenViewOutput {
    weak var view: SearchScreenViewInput?

    private let router: SearchScreenRouter

    var interactor: SearchScreenInteractorInput?

    init(router: SearchScreenRouter) {
        self.router = router
    }
}
