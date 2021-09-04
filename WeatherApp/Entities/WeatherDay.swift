//
//  WeatherDay.swift
//  WeatherApp
//
//  Created by out-nazarov2-ms on 04.09.2021.
//

import Foundation
// "air_pressure" = "<null>";
// "applicable_date" = "2013-04-27";
// created = "2013-04-27T22:52:57.403100Z";
// humidity = 74;
// id = 366945;
// "max_temp" = "10.01";
// "min_temp" = "3.07";
// predictability = 75;
// "the_temp" = "<null>";
// visibility = "9.997862483098704";
// "weather_state_abbr" = lr;
// "weather_state_name" = "Light Rain";
// "wind_direction" = 358;
// "wind_direction_compass" = N;
// "wind_speed" = "9.85";

struct WeatherDay: Codable {
  let airPressure: Double?
  let applicableDate: Date
  let created: Date
  let humidity: Int?
  let id: Int
  let maxTemp: Double?
  let minTemp: Double?
  let predictability: Int
  let theTemp: Double?
  let visibility: Double?
  let weatherStateAbbr: String
  let weatherStateName: String
  let windDirection: Double
  let windDirectionCompass: String
  let windSpeed: Double

//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    airPressure = try container.decode(Double?.self, forKey: .airPressure)
//    created = try container.decode(Date.self, forKey: .created)
//    humidity = try container.decode(Int?.self, forKey: .humidity)
//    id = try container.decode(Int.self, forKey: .id)
//    maxTemp = try container.decode(Double?.self, forKey: .maxTemp)
//    minTemp = try container.decode(Double?.self, forKey: .minTemp)
//    predictability = try container.decode(Int.self, forKey: .predictability)
//    theTemp = try container.decode(Double?.self, forKey: .created)
//    visibility = try container.decode(Double?.self, forKey: .visibility)
//    weatherStateAbbr = try container.decode(String.self, forKey: .weatherStateAbbr)
//    weatherStateName = try container.decode(String.self, forKey: .weatherStateName)
//    windDirection = try container.decode(Double.self, forKey: .windDirection)
//    windDirectionCompass = try container.decode(String.self, forKey: .windDirectionCompass)
//    windSpeed = try container.decode(Double.self, forKey: .windSpeed)
//    applicableDate = try container.decode(String.self, forKey: .applicableDate)
//    let dateString = try container.decode(String.self, forKey: .applicableDate)
//    let formatter = DateFormatter.yyyyMMdd
//    if let date = formatter.date(from: dateString) {
//      applicableDate = date
//    } else {
//      throw DecodingError.dataCorruptedError(forKey: .applicableDate,
//                                             in: container,
//                                             debugDescription: "Date string does not match format expected by formatter.")
//    }
//  }
  //
  //  enum CodingKeys: String, CodingKey {
  //    case airPressure = "air_pressure"
  //    case applicableDate = "applicable_date"
  //    case created
  //    case humidity
  //    case id
  //    case maxTemp = "max_temp"
  //    case minTemp = "min_temp"
  //    case predictability
  //    case theTemp = "the_temp"
  //    case visibility
  //    case weatherStateAbbr = "weather_state_abbr"
  //    case weatherStateName = "weather_state_name"
  //    case windDirection = "wind_direction"
  //    case windDirectionCompass = "wind_direction_compass"
  //    case windSpeed = "wind_speed"
  //  }
}
/*
 struct Day {
 let airPressure: Double?
 let applicableDate: Date
 let created: Date
 let humidity: Int?
 let id: Int
 let maxTemp: Double?
 let minTemp: Double?
 let predictability: Int
 let theTemp: Double?
 let visibility: Double?
 let weatherStateAbbr: String
 let weatherStateName: String
 let windDirection: Double
 let windDirectionCompass: String
 let windSpeed: Double
 init(_ wDay: WeatherDay) {
 airPressure = wDay.airPressure
 applicableDate = DateFormatter().date(from: wDay.applicableDate)!
 created = DateFormatter().date(from: wDay.created)!
 humidity = wDay.humidity!
 id = wDay.id
 maxTemp = wDay.maxTemp!
 minTemp = wDay.minTemp!
 predictability = wDay.predictability
 theTemp = wDay.theTemp!
 visibility = wDay.visibility!
 weatherStateAbbr = wDay.weatherStateAbbr
 weatherStateName = wDay.weatherStateName
 windDirection = wDay.windDirection
 windDirectionCompass = wDay.windDirectionCompass
 windSpeed = wDay.windSpeed
 }
 }
 */
