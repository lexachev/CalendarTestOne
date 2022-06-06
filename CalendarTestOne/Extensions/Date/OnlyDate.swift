//
//  OnlyDate.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import Foundation

extension Date {
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }

}
