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
    func update()
    func viewDidSetup()
    func viewWillSetup()
}

protocol MainForecastScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func tableViewDidSelect(row: Int)
    func searchButtonTapped()
    func settingsButtonTapped()
    var dataSource: MainForecastScreenDataSourceProtocol? { get }
}

protocol MainForecastScreenDataSourceProtocol: UITableViewDataSource {
    func updateForSections(_ sections: [DaySectionModel])
}

protocol MainForecastScreenInteractorProtocol: AnyObject {
    func getNextSixDaysForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void)
    func getRestFourDaysForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void)
    func getWeekForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void)
    func getImages(complition: @escaping ([String: Image]) -> Void)
    func saveImages(_ images: [String: Image])
}

protocol MainForecastScreenRouterProtocol {
    func routeToDaySrceen(cityName: String, day: WeatherDayResponse)
    func routeToSearchScreen(delegate: PresenterPushViewProtocol?)
    func routeToSettingsScreen(delegate: MainForecastScreenPresenterProtocol?)
    func routeToNewCity(cityId: Int, cityName: String)
}
