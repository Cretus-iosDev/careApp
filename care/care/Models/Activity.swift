//
//  Activity.swift
//  care
//
//  Created by rutik maraskolhe on 02/11/21.
//

import Foundation

struct Activity: Identifiable {
    var id: String
    var name: String
    var image: String
    
    static func allActivities() -> [Activity] {
        return [
            Activity(id: "activieEnergyBurned", name: "Active Burned Calories", image: "⚡️"),
            Activity(id: "appleExerciseTime", name: "Exercise Time", image: "🏋🏻‍♂️"),
            Activity(id: "appleStandTime", name: "Stand Time", image: "🧍🏻‍♂️"),
            Activity(id: "distanceWalkingRunning", name: "Distance Walking/Running", image: "🏃🏻‍♂️"),
            Activity(id: "stepCount", name: "Step Count", image: "👣")
        ]
    }
}
