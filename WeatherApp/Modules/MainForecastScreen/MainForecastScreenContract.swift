//
//  MainForecastScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Moya
import UIKit

protocol MainForecastScreenViewProtocol: AnyObject {
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func reloadTableViewData()
    func viewDidSetup()
    func updateMode()
}

protocol MainForecastScreenPresenterProtocol: AnyObject {
    var dataSource: MainForecastScreenDataSourceProtocol { get }

    func viewDidLoad()
    func tableViewDidSelect(row: Int)
    func searchButtonTapped()
    func settingsButtonTapped()
}

protocol PresenterUpdateProtocol: AnyObject {
    func updateView()
}

protocol MainForecastScreenDataSourceProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [DaySectionModel])
}

protocol MainForecastScreenPresenterToCellsProtocol: AnyObject {
    func getImage(for abbr: String) -> UIImage?
}

protocol MainForecastScreenInteractorProtocol: AnyObject {
    func getNextSixDaysForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void)
    func getRestFourDaysForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void)
    func getWeekForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void)
    func getImages(complition: @escaping ([String: UIImage]) -> Void)
    func saveImages(_ images: [String: UIImage])
    func getImage(for abbr: String) -> UIImage?
}

protocol MainForecastScreenRouterProtocol {
    func routeToDaySrceen(cityName: String, day: WeatherDayResponse)
    func routeToSearchScreen(delegate: PresenterPushViewProtocol?)
    func routeToSettingsScreen(delegate: PresenterUpdateProtocol?)
    func routeToNewCity(cityId: Int, cityName: String)
}
