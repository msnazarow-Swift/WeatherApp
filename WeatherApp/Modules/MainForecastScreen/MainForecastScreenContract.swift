//
//  MainForecastScreenContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Moya

protocol MainForecastScreenViewProtocol: class {
    func setCityLabel(city: String)
    func setWeatherLabel(weather: String)
    func setDegreeLabel(degree: Int)
    func setMinMaxDegreeLabel(min: Int, max: Int)
    func update()
    func viewDidSetup()
    func viewWillSetup()
}

protocol MainForecastScreenPresenterProtocol: class {
    func viewDidLoad()
    func tableViewDidSelect(row: Int)
    func searchButtonTapped()
    func settingsButtonTapped()
    var dataSource: MainForecastScreenDataSource { get }
}

protocol MainForecastScreenInteractorProtocol: class {
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
