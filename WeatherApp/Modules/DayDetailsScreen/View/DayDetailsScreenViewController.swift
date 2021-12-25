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

    // TODO: - По какой то причини конкретном на этом вью иначе накладывается на таблицу
    private lazy var vStack = DaySummaryStackView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 170 * verticalTranslation))

    override func viewDidLoad() {
        guard let presenter = presenter else {
            print("DayDetailsScreenViewController Assemble Error")
            return
        }
        super.viewDidLoad()
        setUI()
        presenter.viewDidLoad()
    }

    private func setUI() {
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.register(DescriptionPropertyCell.self, forCellReuseIdentifier: DescriptionPropertyCell.identifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.tableHeaderView = vStack

        tableView.rowHeight = 85 * verticalTranslation
        tableView.tableFooterView = UIView()
        tableView.dataSource = presenter?.dataSource
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)!]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        tableView.isHidden = false
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
