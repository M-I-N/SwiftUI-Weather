//
//  CityRow.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/3/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct CityRow: View {

    @ObservedObject var city: City
    
    var body: some View {
        NavigationLink(destination: CityWeatherDetail(city: city)) {
            HStack {
                Text(city.name)

                Spacer()

                HStack {
                    city.weather?.current.icon.image
                    Text(city.weather?.current.temperature.formattedTemperature ?? "")
                }
            }
            .font(.headline)
        }
        .padding(.vertical)
        .onAppear {
            self.city.fetchWeather()
        }
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(city: City(name: "Dhaka", latitude: 23.810331, longitude: 90.412521))
    }
}

