//
//  WeekScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

protocol WeekScreenViewInput: class {
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

    lazy var weekForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorColor = .clear
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
        guard let presenter = presenter else {
            print("No presenter")
            return
        }
        presenter.loadForCity(cityId: cityId)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableViewHeight = (view.bounds.height - vStack.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 12)
    }

    func setUI() {
        title = "Неделя"
//        weekForecastTableView.t = 243
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        view.backgroundColor = .white
//        view.addSubview(vStack)
        //    view.addSubview(stroke)
        view.addSubview(weekForecastTableView)
        vStack.stroke.snp.makeConstraints { make in
            make.width.equalTo(view)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
//            make.top.equalToSuperview()
//            make.height.greaterThanOrEqualTo(143)
//            make.bottom.equalTo(weekForecastTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.snp.top as! ConstraintRelatableTarget)
        }
//        vStack.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
//            stroke.snp.makeConstraints { make in
//              make.center.equalToSuperview()
//              make.top.equalTo(vStack.snp.bottom).offset(17)
//              make.height.equalTo(1)
//              make.width.equalToSuperview()
//            }

        weekForecastTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview()
//            make.top.equalTo(vStack.snp.bottom)
//            make.bottom.greaterThanOrEqualToSuperview()
        }
//        weekForecastTableView.bounces = false
//        self.weekForecastTableView.setNeedsLayout()
//        self.weekForecastTableView.layoutIfNeeded()
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
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return max(
//            tableViewHeight / CGFloat(sections[indexPath.section].rows.count),
            CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)// ,
//            UITableView.automaticDimension
//        )
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
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
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        243
//    }
}
