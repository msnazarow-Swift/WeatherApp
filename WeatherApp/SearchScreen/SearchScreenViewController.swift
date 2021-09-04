//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol SearchScreenViewInput: class {
    var viewController: UIViewController { get }
    var presenter: SearchScreenViewOutput? { get set }
}

class SearchScreenViewController: UIViewController, SearchScreenViewInput {
	var presenter: SearchScreenViewOutput?

    var viewController: UIViewController { return self }

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
