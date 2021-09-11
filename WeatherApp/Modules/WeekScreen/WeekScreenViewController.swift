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
    func viewDidSetup()
}

class WeekScreenViewController: UITableViewController {
    var presenter: WeekScreenViewOutput?
	let vStack = DaySummaryStackView()
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetup()
        setUI()
        guard let presenter = presenter else {
            print("No presenter")
            return
        }
        presenter.viewDidLoad()
    }
    func viewWillSetup() {
        tableView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
          make.center.equalToSuperview()
        }
        vStack.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        activityIndicator.startAnimating()
    }
    func setUI() {
        tableView.backgroundColor = .init(white: 1.0, alpha: 0.7)

//        tableView.isHidden = true
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.tableHeaderView = vStack
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }

//        tableView.estimatedRowHeight = 61
        tableView.rowHeight = 61
        tableView.tableFooterView = UIView()
//        tableView.sectionHeaderHeight = 174
        title = "Неделя"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)]
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        if let presenter = presenter {
            tableView.dataSource = presenter.dataSource
        }
    }
}

extension WeekScreenViewController: WeekScreenViewInput {
    // TODO: - Я знаю что это нарушает инкапсуляцию, но по сути все эти labels принадлежат текущему view, а vstack просто удобный способ компановки
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

    func viewDidSetup() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            self?.navigationController?.setNavigationBarHidden(false, animated: true)
            self?.activityIndicator.stopAnimating()
            self?.vStack.isHidden = false
            self?.tableView.backgroundColor = .white
        })
    }
}
extension WeekScreenViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter {
            return presenter.tableViewDidSelect(row: indexPath.row)
        }
    }
}
