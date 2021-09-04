//
//  DayScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol DayScreenViewInput: class {
    var viewController: UIViewController { get }
    var presenter: DayScreenViewOutput? { get set }
}

class DayScreenViewController: UIViewController, DayScreenViewInput {
	var presenter: DayScreenViewOutput?

    var viewController: UIViewController { return self }

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
