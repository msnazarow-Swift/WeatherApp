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
    func update()
}

class DayScreenViewController: UITableViewController {
    var presenter: DayScreenViewOutput?
    let vStack = DaySummaryStackView()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.autoresizesSubviews = true
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let header = tableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
        }
    }

    func setUI() {
        tableView.sectionHeaderHeight = 174 * verticalTranslation
        tableView.backgroundColor = .white
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.tableHeaderView = vStack
        tableView.tableFooterView = UIView()
        tableView.dataSource = presenter?.dataSource
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
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

    func update() {
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }
}
