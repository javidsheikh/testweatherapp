//
//  Weather.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 13/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import Foundation
import Marshal

class ThreeHourForecast: Unmarshaling {
    var displayTime: String
    var celsiusTemperature: Int
    var weatherArray: [Weather]
    var windSpeed: Int

    required init(object: MarshaledObject) throws {
        let timeString: String = try object.value(for: "dt_txt")
        let day = DateHelper.getDayFor(date: timeString)
        let date = DateHelper.reverseDateStringFormat(from: timeString)
        let time = timeString.suffix(8)
        displayTime = "\(day) \(date) \(time)"
        let kelvinTemp: Double = try object.value(for: "main.temp")
        celsiusTemperature = Int(round(kelvinTemp - 273.15))
        weatherArray = try object.value(for: "weather")
        let metresPerSecond: Double = try object.value(for: "wind.speed")
        windSpeed = Int(round(metresPerSecond * 2.23694))
    }
    
    struct Weather: Unmarshaling {
        var main: String
        var description: String
        var icon: String
        
        init(object: MarshaledObject) throws {
            main = try object.value(for: "main")
            description = try object.value(for: "description")
            icon = try object.value(for: "icon")
        }
    }
}
