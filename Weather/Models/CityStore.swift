//
//  CityStore.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class CityStore: ObservableObject {
    @Published var cities = [City]()
    @Published var predictedCities = [CityPredictionResponse.Prediction]()

    private let cityClient = CityClient()

    func fetch(searchString: String) {
        cityClient.fetchCitiesPrediction(for: searchString) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let predictions):
                    self.predictedCities = predictions
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func fetchCity(placeID: String) {
        cityClient.fetchCity(for: placeID) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let city):
                    if !self.cities.contains(city) {
                        self.cities.append(city)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
