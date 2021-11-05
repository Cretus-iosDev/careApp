//
//  Date+Extension.swift
//  care
//
//  Created by rutik maraskolhe on 02/11/21.
//

import Foundation


extension Date {
    static func firstDayOfWeek() -> Date {
        //iso8601 is an international standard covering the worldwide exchange and communication of date- and time-related data
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())) ?? Date()
    }
}
