//
//  Double+Extension.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

extension Double {

    var formattedTemperature: String {
        let formatter = NumberFormatter()
        formatter.allowsFloats = false

        let formattedDouble = formatter.string(from: NSNumber(value: self)) ?? "-"
        return formattedDouble + "ºC"
    }

}
