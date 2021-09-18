//
//  MainForecastInteractorTest.swift
//  WeatherAppTests
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import XCTest

class MainForecastInteractorTest: XCTestCase {
    var interactor: MainForecastScreenInteractorProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        interactor = MainForecastScreenInteractor(
            weatherService: WeatherServiceMock(),
            imageStorageService: ImageStorageServiceMock())
    }

    override func tearDownWithError() throws {
        interactor = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        interactor.getRestFourDaysForecast(cityId: 0, complition: <#T##([WeatherDayResponse]) -> Void#>)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
