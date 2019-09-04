//
//  DailyWeather.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

struct DailyWeather: Codable {
    
    var time: Date
    var maxTemperature: Double
    var minTemperature: Double
    var icon: Weather.Icon

    enum CodingKeys: String, CodingKey {

        case time = "time"
        case maxTemperature = "temperatureHigh"
        case minTemperature = "temperatureLow"
        case icon = "icon"

    }

}
