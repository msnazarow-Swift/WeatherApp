//
//  MainForecastScreenDataSource.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 11.09.2021.
//

import UIKit

final class MainForecastScreenDataSource: NSObject, MainForecastScreenDataSourceProtocol {
    weak var presenter: MainForecastScreenPresenterToCellsProtocol?

    private var sections: [DaySectionModel] = []

    func updateForSections(_ sections: [DaySectionModel]) {
        self.sections = sections
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        cell.presenter = presenter
        cell.model = model
        return cell
    }
}
