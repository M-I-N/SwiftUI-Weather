//
//  CityStore.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class CityStore: ObservableObject {
    @Published var cities = [City(name: "Dhaka", latitude: 23.810331, longitude: 90.412521), City(name: "Narsingdi", latitude: 24.134378, longitude: 90.786003), City(name: "Sylhet", latitude: 24.894930, longitude: 91.868706)]
}
