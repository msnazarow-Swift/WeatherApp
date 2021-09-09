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
  func loadForCity(cityId: Int)
}

class WeekScreenViewController: UIViewController {
  var presenter: WeekScreenViewOutput?
  var viewController: UIViewController { return self }
  var cityId: Int = 2122265
  var sections: [DaySectionModel] = []
  var tableViewHeight: CGFloat!
  let vStack = DaySummaryStackView()
  let stroke: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 1))
    view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
    return view
  }()
  let weekForecastTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .white
    tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
    tableView.separatorColor = .clear
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
    presenter.loadForCity(cityId: cityId)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableViewHeight = (view.bounds.height - vStack.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 12)
  }

  func setUI() {
    title = "Неделя"
    navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    view.backgroundColor = .white
    view.addSubview(vStack)
//    view.addSubview(stroke)
    view.addSubview(weekForecastTableView)
    weekForecastTableView.delegate = self
    weekForecastTableView.dataSource = self
    vStack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
      make.height.greaterThanOrEqualTo(143)
    }
    vStack.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
//    stroke.snp.makeConstraints { make in
//      make.center.equalToSuperview()
//      make.top.equalTo(vStack.snp.bottom).offset(17)
//      make.height.equalTo(1)
//      make.width.equalToSuperview()
//    }
    weekForecastTableView.snp.makeConstraints { make in
      make.left.equalToSuperview()
      make.right.equalToSuperview()
      make.top.equalTo(vStack.snp.bottom)
      make.bottom.greaterThanOrEqualToSuperview()
    }
    weekForecastTableView.bounces = false
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
    vStack.minMaxLabel.text = "Макс. \(max)°, мин. \(min)°"
  }

  func updateForSections(_ sections: [DaySectionModel]) {
    self.sections = sections
    weekForecastTableView.reloadData()
  }
  @objc func searchButtonTapped() {
    presenter?.searchButtonTapped()
  }
  func loadForCity(cityId: Int) {
    self.cityId = cityId
  }
}

extension WeekScreenViewController: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(
          tableViewHeight / CGFloat(sections[indexPath.section].rows.count),
          CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight),
          UITableView.automaticDimension
        )
      }
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let presenter = presenter else {
      return
    }
    return presenter.tableViewDidSelect(row: indexPath.row)
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = sections[indexPath.section].rows[indexPath.row]
    if let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? WeatherCell {
    cell.model = model
    return cell
    } else {
      return UITableViewCell()
    }
  }
}
