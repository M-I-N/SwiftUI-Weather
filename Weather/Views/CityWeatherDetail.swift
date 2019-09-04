//
//  CityWeatherDetail.swift
//  Weather
//
//  Created by Mufakkharul Islam Nayem on 9/4/19.
//  Copyright © 2019 Mufakkharul Islam Nayem. All rights reserved.
//

import SwiftUI

struct CityWeatherDetail: View {

    let city: City

    var body: some View {
        List {
            Section(header: Text("Now")) {
                if city.weather != nil {
                    NowWeatherView(weather: city.weather!.current)
                }
            }
            Section(header: Text("Hourly")) {
                if city.weather != nil {
                    HourlyWeatherView(hours: city.weather!.hours)
                    .listRowInsets(EdgeInsets())
                }
            }
        }
        .navigationBarTitle(city.name)
    }
}

struct NowWeatherView: View {

    let weather: HourlyWeather

    var body: some View {
        HStack {
            Spacer()
            weather.icon.image
            Text(weather.temperature.formattedTemperature)
            Spacer()
        }
        .font(.largeTitle)
        .frame(height: 150)
    }
}

struct HourlyWeatherView: View {

    let hours: Weather.List<HourlyWeather>

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(hours.list) { item in
                    HourlyWeatherItem(weather: item)
                }
            }
        }
        .padding(.vertical, 20)
    }

    private struct HourlyWeatherItem: View {

        let weather: HourlyWeather

        var body: some View {
            VStack {
                Text(weather.time.formattedHour)
                weather.icon.image
                Text(weather.temperature.formattedTemperature)
            }
            .frame(width: 100)
//            .background(Color.purple)
        }

    }

}

struct CityWeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetail(city: City(name: "Dhaka", latitude: 23.810331, longitude: 90.412521))
    }
}
