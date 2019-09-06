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
            if city.weather != nil {
                Section(header: Text("Now")) {
                    NowWeatherView(weather: city.weather!.current)
                }
                Section(header: Text("Hourly")) {
                    HourlyWeatherView(hours: city.weather!.hours)
                    .listRowInsets(EdgeInsets())
                }
                Section(header: Text("Weekly")) {
                    WeeklyWeatherView(week: city.weather!.week)
                }
            }
        }
        .navigationBarTitle(Text(city.name), displayMode: .inline)
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

struct WeeklyWeatherView: View {

    let week: Weather.List<DailyWeather>

    var body: some View {
        ForEach(week.list) { item in
            WeeklyWeatherItem(weather: item)
        }
    }

    struct WeeklyWeatherItem: View {

        let weather: DailyWeather

        var body: some View {
            ZStack {
                HStack {
                    Text(weather.time.formattedDay)
                        .font(.subheadline)
                    Spacer()
                    MinMaxTemparatureView(minTemperature: weather.minTemperature, maxTemperature: weather.maxTemperature)
                }
                HStack {
                    Spacer()
                    weather.icon.image
                    .imageScale(.large)
                    Spacer()
                }
            }
        }

        struct MinMaxTemparatureView: View {

            let minTemperature: Double
            let maxTemperature: Double

            var body: some View {
                HStack(spacing: 20) {
                    VStack(alignment: .trailing) {
                        Text("min")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(minTemperature.formattedTemperature)
                            .font(.headline)
                    }
                    VStack(alignment: .trailing) {
                        Text("max")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(maxTemperature.formattedTemperature)
                            .font(.headline)
                    }
                }
            }
        }
    }

}

struct CityWeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherDetail(city: City(name: "Dhaka", latitude: 23.810331, longitude: 90.412521))
    }
}
