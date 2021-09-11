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
    func update()
}

class WeekScreenViewController: UITableViewController {
    var presenter: WeekScreenViewOutput?
    var tableViewHeight: CGFloat!
	let vStack = DaySummaryStackView()

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
        tableView.backgroundColor = .white
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.tableFooterView = UIView()
        title = "Неделя"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        if let presenter = presenter {
            tableView.dataSource = presenter.dataSource
        }
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

    func update() {
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }
}
extension WeekScreenViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter {
            return presenter.tableViewDidSelect(row: indexPath.row)
        }
    }
}
