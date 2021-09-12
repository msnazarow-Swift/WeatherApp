//
//  DayDetailsScreenDataSource.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 11.09.2021.
//

import UIKit

class DayDetailsScreenDataSource: NSObject, DayDetailsScreenDataSourceProtocol {
    var sections: [DescriptionSectionModel] = []

    func updateForSections(_ sections: [DescriptionSectionModel]) {
        self.sections = sections
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(sections[indexPath.section].rows[indexPath.row].cellHeight) // * verticalTranslation
    }

    func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath) as! WeatherCell
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        }
        cell.model = model
        return cell
    }
}
