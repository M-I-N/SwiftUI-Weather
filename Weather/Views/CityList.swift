//
//  CityList.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct CityList: View {

    @EnvironmentObject private var cityStore: CityStore
    @State private var isAddingCity = false

    private var addButton: some View {
        Button(action: {
            self.isAddingCity.toggle()
        }) {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
        }

    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("My Cities")) {
                    ForEach(cityStore.cities) { city in
                        CityRow(city: city)
                    }
                    .onDelete { self.cityStore.removeCities(at: $0) }
                    .onMove { self.cityStore.moveCities(from: $0, to: $1) }
                }
            }
            .navigationBarTitle("Weather")
            .navigationBarItems(leading: EditButton(), trailing: self.addButton)
            .sheet(isPresented: self.$isAddingCity) {
                AddNewCity().environmentObject(self.cityStore)
            }
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList()
    }
}
