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
  func setCityLabel(city: String)
  func setWeatherLabel(weather: String)
  func setDegreeLabel(degree: Int)
  func setMinMaxDegreeLabel(min: Int, max: Int)
  func setDescriptionTable(day: WeatherDay)
  func updateForSections(_ sections: [DescriptionSectionModel])
}

class DayScreenViewController: UIViewController {
  var presenter: DayScreenViewOutput?
  var viewController: UIViewController { return self }
  let cellNames = ["НАПРАВЛЕНИЕ ВЕТРА", "ВЕТЕР", "ВЛАЖНОСТЬ", "ДАВЛЕНИЕ", "ВИДИМОСТЬ"]
  var tableViewHeight: CGFloat!
  var sections: [DescriptionSectionModel] = []

  let vStack = DaySummaryStackView()
  let infoTableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .brown
    tableView.register(PropertyTableViewCell.self, forCellReuseIdentifier: PropertyTableViewCell.identifier)
    tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
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
    //    presenter.viewDidLoad()
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
    super.viewDidLayoutSubviews()
    tableViewHeight = (view.bounds.height - vStack.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 12)
  }
}

extension DayScreenViewController: DayScreenViewInput {
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

  func updateForSections(_ sections: [DescriptionSectionModel]) {
    self.sections = sections
    infoTableView.reloadData()
  }
  func setDescriptionTable(day: WeatherDay) {
    var sections: [DescriptionSectionModel] = []
    sections.append(DescriptionSectionModel(DescriptionPropertyModel(title: "Направление Ветра", description: day.windDirectionCompass)))
    sections.append(DescriptionSectionModel(DescriptionPropertyModel(title: "Ветер", description: "\(String(format: "%.1f", day.windSpeed)) м/с")))
    if let humidity = day.humidity {
      sections.append(DescriptionSectionModel(DescriptionPropertyModel(title: "Влажность", description: "\(humidity) %")))
    }
    if let airPressure = day.airPressure {
      sections.append(DescriptionSectionModel(DescriptionPropertyModel(title: "Давление", description: "\(Int(airPressure)) мм рт.cт")))
    }
    if let visibility = day.visibility {
      sections.append(DescriptionSectionModel(DescriptionPropertyModel(title: "Видимость", description: "\(String(format: "%.2f", visibility)) км")))
    }
    updateForSections(sections)
  }
}

extension DayScreenViewController: UITableViewDelegate, UITableViewDataSource {
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  tableViewHeight / CGFloat(sections.count)
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
    //    guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.identifier, for: indexPath) as? PropertyTableViewCell else {
    //      return UITableViewCell()
    //    }
    //    cell.textLabel?.text = cellNames[indexPath.row]
    //    cell.detailTextLabel?.text = "Ю-З"
    //    return (cell)
  }
}
