//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol MainScreenViewInput: class {
  var viewController: UIViewController { get }
  var presenter: MainScreenViewOutput? { get set }
}

class MainScreenViewController: UIViewController, MainScreenViewInput {
  var presenter: MainScreenViewOutput?

  var viewController: UIViewController { return self }

  override func loadView() {
    super.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let presenter = presenter else {
      print("No presenter")
      return
    }
    presenter.viewDidLoad()
      }
}
