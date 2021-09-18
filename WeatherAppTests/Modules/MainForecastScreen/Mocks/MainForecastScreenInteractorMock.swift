//
//  MainForecastInteractorMock.swift
//  MainForecastScreenPresenterTest
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import UIKit

class MainForecastInteractorMock: MainForecastScreenInteractorProtocol {
    func getNextSixDaysForecast(cityId: Int, complition: @escaping (WeatherWeekResponse) -> Void) {
        complition(weatherWeekResponse)
    }

    func getRestFourDaysForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void) {
        complition([weatherDayResponse])
    }

    func getWeekForecast(cityId: Int, complition: @escaping ([WeatherDayResponse]) -> Void) {
        complition([weatherDayResponse])
    }

    func getImages(complition: @escaping ([String: UIImage]) -> Void) {
        complition(["none": UIImage()])
    }

    func saveImages(_ images: [String: UIImage]) {
    }

    func getImage(for abbr: String) -> UIImage? {
        UIImage()
    }
}
