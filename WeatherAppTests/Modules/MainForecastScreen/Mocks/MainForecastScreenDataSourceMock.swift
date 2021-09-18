//
//  MainForecastScreenDataSourceMock.swift
//  MainForecastScreenPresenterTest
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import UIKit

class MainForecastScreenDataSourceMock: NSObject, MainForecastScreenDataSourceProtocol {
    func updateForSections(_ sections: [DaySectionModel]) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
