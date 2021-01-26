//
//  COORD.swift
//  MyForcast
//
//  Created by 1 on 26.01.2021.
//

import Foundation

class MainCurrentWeatherJson: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
}
