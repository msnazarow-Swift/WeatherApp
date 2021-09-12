//
//  MainForecastScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

class MainForecastScreenViewController: UITableViewController {
    var presenter: MainForecastScreenPresenterProtocol?
    let vStack = DaySummaryStackView()
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        guard let presenter = presenter else {
            print("MainForecastScreenViewController Assemble Error")
            return
        }
        super.viewDidLoad()
        viewWillSetup()
        setUI()
        presenter.viewDidLoad()
    }

    func viewWillSetup() {
        navigationController?.view.backgroundColor = .init(white: 1.0, alpha: 0.7)
        tableView.isHidden = true
        navigationController?.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        vStack.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        activityIndicator.startAnimating()
    }

    func setUI() {
        tableView.backgroundColor = .white
        tableView.register(DayCell.self, forCellReuseIdentifier: DayCell.identifier)
        tableView.separatorColor = .clear
        tableView.bounces = false
        tableView.tableHeaderView = vStack
        tableView.rowHeight = 61 * verticalTranslation
        tableView.tableFooterView = UIView()
        title = "Неделя"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.medium(16 * verticalTranslation)!]
        navigationItem.rightBarButtonItems = [
            .init(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)),
            .init(image: UIImage(systemName: "gear"), style: .plain, target: self, action:  #selector(settingsButtonTapped))
        ]
        tableView.dataSource = presenter?.dataSource

        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    }

    func viewDidSetup() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { [weak self] in
            self?.navigationController?.view.backgroundColor = .clear
            self?.navigationController?.setNavigationBarHidden(false, animated: true)
            self?.activityIndicator.stopAnimating()
            self?.vStack.isHidden = false
            self?.tableView.isHidden = false
        })
    }
}

extension MainForecastScreenViewController: MainForecastScreenViewProtocol {
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

    func reloadTableViewData() {
        tableView.reloadData()
    }

    @objc func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }

    @objc func settingsButtonTapped() {
        presenter?.settingsButtonTapped()
    }
    func updateMode() {
        viewWillSetup()
        presenter?.viewDidLoad()
    }
}

extension MainForecastScreenViewController {
    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let presenter = presenter {
            return presenter.tableViewDidSelect(row: indexPath.row)
        }
    }
}
