//
//  HourlyWeather.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

struct HourlyWeather: Codable {

    var time: Date
    var temperature: Double
    var icon: Weather.Icon

}
