//
//  WeatherAppContract.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 12.09.2021.
//

import Moya

protocol WeatherServiceProtocol {
    func getWeekForCity(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void)
    func getDayForCity(cityId: Int, day: Date, complition: @escaping (Result<WeatherDayResponse, Error>) -> Void)
    func getImage(imageAbbreviation: String, complition: @escaping (Result<Image, Error>) -> Void)
}

protocol StorageServiceProtocol {
    func saveImages(_ images: [String: UIImage])
    func getImageForKey(_ key: String) -> UIImage?
    var isWeekMode: Bool { get set }
}

protocol PresenterPushViewProtocol: AnyObject {
    func pushNewCity(cityId: Int, cityName: String)
}
