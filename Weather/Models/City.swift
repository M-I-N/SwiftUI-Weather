//
//  City.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class City: ObservableObject, Identifiable, Decodable, Equatable {
    let name: String
    let latitude: Double
    let longitude: Double
    @Published var weather: Weather?

    private let client = WeatherClient()

    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    required init(from decoder: Decoder) throws {
        let cityResponse = try CityEndpointResponse(from: decoder)
        name = cityResponse.result.name
        latitude = cityResponse.result.geometry.location.lat
        longitude = cityResponse.result.geometry.location.lng
    }

    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
            && lhs.latitude == rhs.latitude
            && lhs.longitude == rhs.longitude
    }

    func fetchWeather() {
        client.fetchWeather(from: WeatherEndpoint(city: self)) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.weather = weather
                case .failure(let error):
                    print(error.customDescription)
                    self.weather = nil
                }
            }
        }
    }

}
