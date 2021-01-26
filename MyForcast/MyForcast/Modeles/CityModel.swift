//
//  CityModel.swift
//  MyForcast
//
//  Created by 1 on 26.01.2021.
//

import Foundation

class Citymodel {

    var cityName: String?
    var temperature: Double?
    
    init (name: String, temperature: Double) {

        self.cityName = name
        self.temperature = temperature
    }
}
