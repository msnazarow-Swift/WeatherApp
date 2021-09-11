//
//  SearchScreenViewController.swift
//  WeatherApp
//
//  Created out-nazarov2-ms on 04.09.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SnapKit
import UIKit

protocol SearchScreenViewInput: class {
    func updateForSections(_ sections: [CitySectionModel])
}

class SearchScreenViewController: UIViewController {
    var presenter: SearchScreenViewOutput?
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Поиск Города"
        label.textAlignment = .center
        label.font = UIFont(name: "Roboto-Medium", size: 16)
        return label
    }()
	let searchTextField = SearchTextField()
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()
    let stroke: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        return view
    }()
    lazy var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        tableView.tableHeaderView = UIView()
        tableView.tableHeaderView?.addSubview(titleLabel)
        tableView.tableHeaderView?.addSubview(searchTextField)
        tableView.tableHeaderView?.addSubview(closeButton)
        tableView.tableHeaderView?.addSubview(stroke)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView?.snp.makeConstraints({ make in
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualTo(108)
        })
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.centerX.equalToSuperview()
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(16)
        }
        searchTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(30)
        }
        stroke.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(1)
        }
        searchTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEndOnExit)
        return tableView
    }()

    var sections: [CitySectionModel] = []
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
    }

    func setupUI() {
        view.addSubview(citiesTableView)
        view.backgroundColor = .white
        citiesTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func editingDidEnd() {
        if let presenter = presenter, let text = searchTextField.text, !text.isEmpty {
            presenter.searchForCity(city: text)
        }
    }
    @objc func closeView() {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchScreenViewController: SearchScreenViewInput {
    func updateForSections(_ sections: [CitySectionModel]) {
        self.sections = sections
        citiesTableView.reloadData()
    }
}

extension SearchScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight)
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
}
