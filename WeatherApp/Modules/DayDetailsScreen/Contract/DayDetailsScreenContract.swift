//
//  DayDetailsScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import UIKit

protocol DayDetailsScreenViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func reloadTableViewData()
}

protocol DayDetailsScreenPresenterProtocol: AnyObject {
    var dataSource: DayDetailsScreenDataSourceProtocol { get }
    
    func searchButtonTapped()
    func setDescriptionTable(day: WeatherDayResponse)
    func viewDidLoad()
}

protocol DayDetailsScreenDataSourceProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [DescriptionSectionModel])
}

protocol DayDetailsScreenRouterProtocol {
    func routeToSearchScreen(delegate: PresenterPushViewProtocol?)
    func routeToNewCity(cityId: Int, cityName: String)
}
