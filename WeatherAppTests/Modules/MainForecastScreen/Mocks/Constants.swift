//
//  Constants.swift
//  WeatherAppTests
//
//  Created by out-nazarov2-ms on 17.09.2021.
//

@testable import WeatherApp
import Foundation

let weatherDayResponse = WeatherDayResponse(
    airPressure: nil,
    applicableDate: Date().byAddingDay(4),
    created: Date(),
    humidity: nil,
    id: 0,
    maxTemp: nil,
    minTemp: nil,
    predictability: 0,
    theTemp: nil,
    visibility: nil,
    weatherStateAbbr: "none",
    weatherStateName: "none",
    windDirection: 0,
    windDirectionCompass: "none",
    windSpeed: 0)

let weatherCityResponse = WeatherCityResponse(
    lattLong: "none",
    locationType: "none",
    title: "none",
    woeid: 0)

let weatherSourceResponce = WeatherSourceResponse(
    crawlRate: 0,
    slug: "none",
    title: "none",
    url: URL(string: "https://example.com")!)

let weatherWeekResponse = WeatherWeekResponse(
    consolidatedWeather: [weatherDayResponse],
    lattLong: "none",
    locationType: "none",
    parent: weatherCityResponse,
    sources: [weatherSourceResponce],
    sunRise: Date().byAddingDay(4),
    sunSet: Date().byAddingDay(4),
    time: Date().byAddingDay(4),
    timezone: "none",
    title: "none",
    woeid: 0)
