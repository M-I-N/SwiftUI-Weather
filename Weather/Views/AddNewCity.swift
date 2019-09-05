//
//  AddNewCity.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/5/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct AddNewCity: View {

    @EnvironmentObject private var cityStore: CityStore
    @Environment(\.presentationMode) var presentationMode
    @State private var search = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search City", text: $search, onEditingChanged: { _ in
                        self.cityStore.fetch(searchString: self.search)
                    })
                }
                if cityStore.predictedCities.count > 0 {
                    Section(header: Text("Cities matching searched keyword")) {
                        ForEach(cityStore.predictedCities) { predictedCity in
                            Button(action: {
                                self.cityStore.fetchCity(placeID: predictedCity.placeID)
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text(predictedCity.description)
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Add New City", displayMode: .inline)
        }
    }
}

struct AddNewCity_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCity()
    }
}
