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
    let vStack = SearchScreenHeaderStackView()// frame: CGRect(x: 0, y: 0, width: 375, height: 108))
    lazy var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
//        tableView.tableHeaderView = vStack
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
        title = "Поиск города"
//        view.addSubview(searchHeader)
//        view.addSubview(searchTextField)
        citiesTableView.tableHeaderView = vStack
//        citiesTableView.sectionHeaderHeight = 108
        view.addSubview(citiesTableView)
        view.backgroundColor = .white
        vStack.searchTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEndOnExit)
//        vStack.closeButton.action = #selector(closeView)
//        vStack.closeButton.target = self
        vStack.button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        citiesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.top.equalTo(searchTextField.snp.bottom)
//            make.left.equalTo(view.safeAreaLayoutGuide)
//            make.right.equalTo(view.safeAreaLayoutGuide)
//            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        vStack.snp.makeConstraints { make in
//            make.right.top.left.equalTo(view)
            make.top.equalToSuperview()
//            make.top.equalTo(view).offset(14).labeled("vStackTop")
            make.left.equalTo(view).offset(16).labeled("vStackLeft")
            make.right.equalTo(view).inset(16).labeled("vStackRight")
//            make.height.equalTo(108).labeled("searchTextFieldHeight")
        }
//        searchHeader.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(10).labeled("searchHeaderTop")
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20).labeled("searchHeaderLeft")
//            make.right.equalTo(view.safeAreaLayoutGuide).inset(20).labeled("searchHeaderRight")
//            make.height.equalTo(40).labeled("searchHeaderHeight")
//        }
//        vStack.searchTextField.snp.makeConstraints { make in
//            make.top.equalTo(searchHeader.snp.bottom).offset(10).labeled("searchTextFieldTop")
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(16).labeled("searchTextFieldLeft")
//            make.right.equalTo(view.safeAreaLayoutGuide).inset(16).labeled("searchTextFieldRight")
//            make.height.equalTo(30).labeled("searchTextFieldHeight")
//        }
    }

    @objc func editingDidEnd() {
        if let presenter = presenter, let text = vStack.searchTextField.text, !text.isEmpty {
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
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        108
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        vStack
//    }
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
