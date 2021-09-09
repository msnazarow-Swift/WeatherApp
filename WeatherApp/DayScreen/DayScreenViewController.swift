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
    var viewController: UIViewController { return self }
    var tableViewHeight: CGFloat = 0
    var sections: [DescriptionSectionModel] = []

    let vStack = DaySummaryStackView()

    let stroke: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 0))
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        return view
    }()

    lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        view.backgroundColor = .white
        view.addSubview(vStack)
        view.addSubview(stroke)
        view.addSubview(infoTableView)

        vStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
//        stroke.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(vStack.snp.bottom)
//        }
        infoTableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(vStack.snp.bottom)
            make.bottom.greaterThanOrEqualToSuperview()
        }
        infoTableView.bounces = false
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
        return max(tableViewHeight / CGFloat(sections[indexPath.section].rows.count),
                   CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight),
                   UITableView.automaticDimension)
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
        cell.model = model
        return cell
    }
}
