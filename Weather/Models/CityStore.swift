//
//  CityStore.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import Foundation

class CityStore: ObservableObject {
    @Published private (set) var cities = [City]()
    @Published private (set) var predictedCities = [City]()

    private let cityClient = CityClient()

    func fetchCities(search: String) {
        guard !search.isEmpty else {
            predictedCities = []
            return
        }
        cityClient.fetchCitiesPrediction(for: search) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let cities):
                    self.predictedCities = cities
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func insertNew(city: City) {
        if !cities.contains(city) {
            cities.append(city)
        }
    }

    func removeCities(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }

    func moveCities(from offsets: IndexSet, to offset: Int) {
        cities.move(fromOffsets: offsets, toOffset: offset)
    }
}

class Person: Decodable {
    let name: String
}
