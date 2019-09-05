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

    func fetchCitiesPrediction(for name: String, completion: @escaping (Result<[CityPredictionResponse.Prediction], APIError>) -> Void) {
        let endpoint = CityPredictionEndpoint(search: name)
        let predictionResponseCompletionClosure: ((Result<CityPredictionResponse, APIError>) -> Void) = { result in
            switch result {
            case .success(let predictionResponse):
                completion(.success(predictionResponse.predictions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        fetch(with: endpoint.request, completion: predictionResponseCompletionClosure)
    }

    func fetchCity(for placeID: String, completion: @escaping (Result<City, APIError>) -> Void) {
        let endpoint = CityEndpoint(placeID: placeID)
        fetch(with: endpoint.request, completion: completion)
    }

}

struct CityPredictionEndpoint: Endpoint {
    let base = "https://maps.googleapis.com"
    let path = "/maps/api/place/autocomplete/json"
    var queryItems: [URLQueryItem]? = [ URLQueryItem(name: "types", value: "(cities)"),
                                        URLQueryItem(name: "key", value: CityPredictionEndpoint.apiKey) ]
    let search: String

    private static let apiKey = "AIzaSyByP6q86K5jl1XZao4tdqQWiCAe-G_2Kxk"

    init(search: String) {
        self.search = search
        queryItems?.insert(URLQueryItem(name: "input", value: search), at: 0)
    }

}

struct CityEndpoint: Endpoint {
    let base = "https://maps.googleapis.com"
    let path = "/maps/api/place/details/json"
    var queryItems: [URLQueryItem]? = [ URLQueryItem(name: "key", value: CityEndpoint.apiKey) ]

    let placeID: String

    private static let apiKey = "AIzaSyByP6q86K5jl1XZao4tdqQWiCAe-G_2Kxk"

    init(placeID: String) {
        self.placeID = placeID
        queryItems?.insert(URLQueryItem(name: "placeid", value: placeID), at: 0)
    }

}

struct CityPredictionResponse: Codable {
    let predictions: [Prediction]

    struct Prediction: Codable, Identifiable {
        
        var id: String {
            return placeID
        }

        let description: String
        let placeID: String
        let structuredFormatting: StructuredFormatting

        enum CodingKeys: String, CodingKey {
            case description
            case placeID = "place_id"
            case structuredFormatting = "structured_formatting"
        }

        struct StructuredFormatting: Codable {
            let mainText: String

            enum CodingKeys: String, CodingKey {
                case mainText = "main_text"
            }
        }

    }
}

struct CityEndpointResponse: Codable {
    let result: Result

    struct Result: Codable {
        let name: String
        let geometry: Geometry

        struct Geometry: Codable {
            let location: Location
        }

        struct Location: Codable {
            let lat: Double
            let lng: Double
        }
    }
}
