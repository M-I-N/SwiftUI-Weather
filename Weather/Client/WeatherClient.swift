//
//  WeatherClient.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class WeatherClient: GenericAPIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func fetchWeather(from endpoint: WeatherEndpoint, completion: @escaping (Result<Weather, APIError>) -> Void) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        self.fetch(with: endpoint.request, decoder: decoder, completion: completion)
    }

}

struct WeatherEndpoint: Endpoint {
    let base = "https://api.darksky.net"
    let path: String
    let queryItems: [URLQueryItem]? = [URLQueryItem(name: "units", value: "ca")]

    private static let apiKey = "030368cd98bcdede4506c4ece3a1a0ba"
    private let city: City

    init(city: City) {
        self.city = city
        path = "/forecast/" + WeatherEndpoint.apiKey + "/" + "\(city.latitude),\(city.longitude)"
    }
}
