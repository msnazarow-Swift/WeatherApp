//
//  MainForecastScreenPresenterTest.swift
//  MainForecastScreenPresenterTest
//
//  Created by out-nazarov2-ms on 03.09.2021.
//

@testable import WeatherApp
import XCTest

class MainForecastScreenPresenterTest: XCTestCase {
    var presenter: MainForecastScreenPresenterProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       presenter = MainForecastScreenPresenter(
        router: MainForecastRouterMock(),
        cityId: 0,
        cityName: "none",
        dataSource: MainForecastScreenDataSourceMock(),
        settingsStorageService: SettingsStorageServiceMock())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
    }

    func testExample() throws {
        // given

        // when

        // than

        XCTAssertEqual(1, 0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
