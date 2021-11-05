//
//  HealthStat.swift
//  care
//
//  Created by rutik maraskolhe on 02/11/21.
//

import Foundation
import HealthKit

struct HealthStat:  Identifiable {
    var id = UUID() // universally unique identifier
    let stat: HKQuantity? //healthkit quantity
    let date: Date
}
