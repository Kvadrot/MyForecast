//
//  MainForcast.swift
//  MyForcast
//
//  Created by 1 on 27.01.2021.
//

import Foundation


class MainForcast: Codable {

    var dt: Int?
    var temp: Temp?
}

class Temp: Codable {

    var day: Double?
}
