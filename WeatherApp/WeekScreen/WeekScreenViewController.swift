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

class WeekScreenViewController: UITableViewController {
    var presenter: WeekScreenViewOutput?
    var cityId: Int = 2122265
    var sections: [DaySectionModel] = []
    var tableViewHeight: CGFloat!
	let vStack = DaySummaryStackView()

//

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
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let header = tableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
        }
    }
// TODO: - Не скроллится при старте
    func setUI() {
        tableView.backgroundColor = .white
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        title = "Неделя"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 16 * verticalTranslation)]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
//        view.backgroundColor = .white
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
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }

    func loadForCity(cityId: Int) {
        self.cityId = cityId
    }
}

extension WeekScreenViewController {
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  		return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
    }

    override func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        vStack
    }
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        174 * fontTrans
//    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter {
        	return presenter.tableViewDidSelect(row: indexPath.row)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? WeatherCell {
            cell.model = model
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension UITableView {
    func setAndLayoutTableHeaderView(header: UIView) {
        header.frame.size = header.systemLayoutSizeFitting(CGSize(width: self.frame.size.width, height: .greatestFiniteMagnitude))
        self.tableHeaderView = header
    }
}
