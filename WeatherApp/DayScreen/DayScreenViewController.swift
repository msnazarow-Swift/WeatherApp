//
//  DayScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

protocol DayScreenViewInput: class {
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func setDescriptionTable(day: WeatherDay)
    func updateForSections(_ sections: [DescriptionSectionModel])
}

class DayScreenViewController: UIViewController {
    var presenter: DayScreenViewOutput?
    var tableViewHeight: CGFloat = 0
    var sections: [DescriptionSectionModel] = []

    let vStack = DaySummaryStackView()

    lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = vStack
        return tableView
    }()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        infoTableView.autoresizesSubviews = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let header = infoTableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
        }
    }

    func setUI() {
        view.backgroundColor = .white
        view.addSubview(infoTableView)
        vStack.stroke.snp.makeConstraints { make in
            make.width.equalTo(view)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        infoTableView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
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
        var models: [DescriptionPropertyModel] = []
        models.append(DescriptionPropertyModel(title: "Направление Ветра", description: day.windDirectionCompass))
        models.append(DescriptionPropertyModel(title: "Ветер", description: "\(String(format: "%.1f", day.windSpeed)) м/с"))
        if let humidity = day.humidity {
            models.append(DescriptionPropertyModel(title: "Влажность", description: "\(humidity) %"))
        }
        if let airPressure = day.airPressure {
            models.append(DescriptionPropertyModel(title: "Давление", description: "\(Int(airPressure)) мм рт.cт"))
        }
        if let visibility = day.visibility {
            models.append(DescriptionPropertyModel(title: "Видимость", description: "\(String(format: "%.2f", visibility)) км"))
        }
        sections.append(DescriptionSectionModel(models))
        updateForSections(sections)
    }
}

extension DayScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as! WeatherCell
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        cell.model = model
        return cell
    }
}
