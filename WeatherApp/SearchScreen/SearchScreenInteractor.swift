//
//  SearchScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol SearchScreenInteractorInput: class {
    var presenter: SearchScreenInteractorOutput? { get set }
}

protocol SearchScreenInteractorOutput: class {
}

class SearchScreenInteractor: SearchScreenInteractorInput {
    weak var presenter: SearchScreenInteractorOutput?
}
