//
//  DayScreenInteractor.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol DayScreenInteractorInput: class {
    var presenter: DayScreenInteractorOutput? { get set }
}

protocol DayScreenInteractorOutput: class {
}

class DayScreenInteractor: DayScreenInteractorInput {
    weak var presenter: DayScreenInteractorOutput?
}
