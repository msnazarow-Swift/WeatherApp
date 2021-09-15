//
//  DayDetailsScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

final class DayDetailsScreenViewController: UITableViewController {
    var presenter: DayDetailsScreenPresenterProtocol?
    private let vStack = DaySummaryStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.autoresizesSubviews = true
        presenter?.viewDidLoad()
    }

    // TODO: - Я знаю что это плохо, но по другому не робит

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let header = tableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: 0)).height
        }
    }

    private func setUI() {
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.tableHeaderView = vStack
//        tableView.sectionHeaderHeight = 170 * verticalTranslation
        tableView.rowHeight = 85 * verticalTranslation
        tableView.tableFooterView = UIView()
        tableView.dataSource = presenter?.dataSource
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)!]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
}

extension DayDetailsScreenViewController: DayDetailsScreenViewProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }

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

    func reloadTableViewData() {
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }
}
