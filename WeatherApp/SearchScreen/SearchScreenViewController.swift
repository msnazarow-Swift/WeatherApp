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
  let searchTextField: UITextField = {
    let textField = UITextField()
    textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    return textField
  }()
  let citiesTableView = UITableView()
  var viewController: UIViewController { return self }

  override func loadView() {
    super.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    title = "Поиск Города"
    view.addSubview(searchTextField)
    view.addSubview(citiesTableView)
    view.backgroundColor = .white
    searchTextField.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(40)
    }
    citiesTableView.snp.makeConstraints { make in
      make.top.equalTo(searchTextField.snp.bottom)
      make.left.equalTo(view.safeAreaLayoutGuide)
      make.right.equalTo(view.safeAreaLayoutGuide)
      make.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  @objc func editingDidEnd() {
    if let presenter = presenter, let text = searchTextField.text {
      presenter.searchForCity(city: text)
    }
  }
}
