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
  func updateForSections(_ sections: [DaySectionModel])
}

class WeekScreenViewController: UIViewController {
  var presenter: WeekScreenViewOutput?
  var viewController: UIViewController { return self }

  var sections: [DaySectionModel] = []

  let vStack = DaySummaryStackView()
  let weekForecastTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .brown
    tableView.register(PropertyTableViewCell.self, forCellReuseIdentifier: PropertyTableViewCell.identifier)
    tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
    tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

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

  override func viewDidLayoutSubviews() {
    weekForecastTableView.rowHeight = (view.bounds.height - vStack.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 12)
//    weekForecastTableView.rowHeight /= CGFloat(sections.count)
  }

  func setUI() {
    view.backgroundColor = .white
    view.addSubview(vStack)
    view.addSubview(weekForecastTableView)
    weekForecastTableView.delegate = self
    weekForecastTableView.dataSource = self
    vStack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
    }
    weekForecastTableView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.top.equalTo(vStack.snp.bottom)
      make.bottom.greaterThanOrEqualToSuperview()
    }
    weekForecastTableView.isScrollEnabled = false
  }
}
extension WeekScreenViewController: WeekScreenViewInput {
  func setCityLabel(city: String) {
    vStack.cityLabel.text = city
  }

  func setWeatherLabel(weather: String) {
    vStack.weatherLabel.text = weather
  }

  func setDegreeLabel(degree: Int) {
    vStack.degreeLabel.text = "\(degree)°"
  }

  func setMinMaxDegreeLabel(min: Int, max: Int) {
    vStack.minMaxLabel.text = "Макс. \(min)°, мин. \(max)°"
  }

  func updateForSections(_ sections: [DaySectionModel]) {
    self.sections = sections
    weekForecastTableView.reloadData()
  }
}

extension WeekScreenViewController: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return weekForecastTableView.rowHeight / CGFloat(sections.count)
      }
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
//  }
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
  }
}
