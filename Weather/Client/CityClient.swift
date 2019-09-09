//
//  CityClient.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/5/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class CityClient: GenericAPIClient {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func fetchCitiesPrediction(for search: String, completion: @escaping (Result<[City], APIError>) -> Void) {
        let endpoint = CityEndpoint(search: search)
        fetch(with: endpoint.request, completion: completion)
    }

}

struct CityEndpoint: Endpoint {
    let base = "https://api.apixu.com"
    let path = "/v1/search.json"
    var queryItems: [URLQueryItem]? = [ URLQueryItem(name: "key", value: CityEndpoint.apiKey) ]

    let search: String

    private static let apiKey = "06fe0829b7204ef386a71932190909"

    init(search: String) {
        self.search = search
        queryItems?.insert(URLQueryItem(name: "q", value: search), at: 0)
    }

}
