//
//  DateHelper.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 14/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getDayFor(date dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)!
        let calender = Calendar.current
        let component = calender.component(.weekday, from: date)
        switch component {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return ""
        }
    }
    
    static func reverseDateStringFormat(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)!
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
