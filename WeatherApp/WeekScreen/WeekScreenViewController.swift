//
//  WeekScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

protocol WeekScreenViewInput: class {
  var viewController: UIViewController { get }
  var presenter: WeekScreenViewOutput? { get set }
  func setCityLabel(city: String)
  func setWeatherLabel(weather: String)
  func setDegreeLabel(degree: Int)
  func setMinMaxDegreeLabel(min: Int, max: Int)
}

class WeekScreenViewController: UIViewController {
  var presenter: WeekScreenViewOutput?

  let cellNames = ["НАПРАВЛЕНИЕ ВЕТРА", "ВЕТЕР", "ВЛАЖНОСТЬ", "ДАВЛЕНИЕ", "ВИДИМОСТЬ"]

  var sections: [WeatherSectionModel] = []

  let cityLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Medium", size: 25)
    return (label)
  }()

  let weatherLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12)
    return (label)
  }()

  let degreeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Light", size: 60)
    return (label)
  }()

  let minMaxLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Roboto-Regular", size: 12)
    return (label)
  }()

  lazy var vStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [cityLabel, weatherLabel, degreeLabel, minMaxLabel])
    stack.axis = .vertical
    stack.spacing = 5
    stack.alignment = .center
    return (stack)
  }()
  let infoTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .brown
    tableView.register(PropertyTableViewCell.self, forCellReuseIdentifier: PropertyTableViewCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  var viewController: UIViewController { return self }

  override func loadView() {
    super.loadView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    guard let presenter = presenter else {
      print("No presenter")
      return
    }
    presenter.viewDidLoad()
  }
  func setUI() {
    view.backgroundColor = .white
    view.addSubview(vStack)
    view.addSubview(infoTableView)
    infoTableView.delegate = self
    infoTableView.dataSource = self
    vStack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
    }
    infoTableView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.top.equalTo(vStack.snp.bottom)
      make.bottom.greaterThanOrEqualToSuperview()
    }
    infoTableView.isScrollEnabled = false
  }
  override func viewDidLayoutSubviews() {
    infoTableView.rowHeight = (view.bounds.height - vStack.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 12) / 5
  }

  func updateForSections(_ sections: [WeatherSectionModel]) {
          self.sections = sections

    infoTableView.reloadData()
      }
}
extension WeekScreenViewController: WeekScreenViewInput {
  func setCityLabel(city: String) {
    cityLabel.text = city
  }

  func setWeatherLabel(weather: String) {
    weatherLabel.text = weather
  }

  func setDegreeLabel(degree: Int) {
    degreeLabel.text = "\(degree)°"
  }

  func setMinMaxDegreeLabel(min: Int, max: Int) {
    minMaxLabel.text = "Макс. \(min)°, мин. \(max)°"
  }
}


extension WeekScreenViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//      return  (view.bounds.height - vStack.bounds.height) / 5
//    }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
      }
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sections[indexPath.section].rows[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as! WeatherCell
            cell.model = model
            return cell
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.identifier, for: indexPath) as? PropertyTableViewCell else {
//      return UITableViewCell()
//    }
//    cell.textLabel?.text = cellNames[indexPath.row]
//    cell.detailTextLabel?.text = "Ю-З"
//    return (cell)
  }
}
