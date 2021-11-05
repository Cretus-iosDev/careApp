//
//  HKRepository.swift
//  care
//
//  Created by rutik maraskolhe on 02/11/21.
//

import Foundation
import HealthKit

final class HKRespository {
    var store: HKHealthStore?
    
    
    //when we query the healthkit data for that query. we need what kind of enitity we aspecting . so we are creating an array which will we saving the all entity type.
    let allTypes = Set([
        HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
        HKObjectType.quantityType(forIdentifier: .appleExerciseTime)!,
        HKObjectType.quantityType(forIdentifier: .appleStandTime)!,
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        
    ])
    
    
    //optional type query
    var query: HKStatisticsCollectionQuery?
    init(){
        store = HKHealthStore()
    }
    
    // we need to first need to request the authorization for the access to the health stats
    //@escaping ->  used to inform callers of a function that takes a closure that the closure might be stored 
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let store = store else {
            return
        }
        
        store.requestAuthorization(toShare: [], read: allTypes) { success, error in
            completion(success)
        }
    }
    //
    func requestHealthStat(by category: String, completion: @escaping ([HealthStat]) -> Void) {
        //guard keyword lets us check an optional exists and exit the current scope if it doesn't, which makes it perfect for early returns in methods.
        guard let store = store, let type = HKObjectType.quantityType(forIdentifier: typeByCategory(category: category)) else {
            return
        }
        
        //about the calender
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        let endDate = Date()
        let anchorDate  = Date.firstDayOfWeek()
        let dailyComponent  = DateComponents(day: 1)

        var healthStats = [HealthStat]()
        
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)

        query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: dailyComponent)
        
        query? .initialResultsHandler = {
            query,statistics, error in statistics?.enumerateStatistics(from: startDate, to: endDate, with:  {
                stats, _ in
                let stat = HealthStat(stat: stats.sumQuantity(), date: stats.startDate)
                healthStats.append(stat)
            })
            
            completion(healthStats)
        }
        guard  let query = query else {
            return
        }
        
        
        store.execute(query)

    }
    
    //typeByCategory is the helper function
    private func typeByCategory (category: String) ->  HKQuantityTypeIdentifier {
        switch category {
        case "activieEnergyBurned":
            return .activeEnergyBurned
        case "appleExerciseTime":
            return .appleExerciseTime
        case "appleStandTime":
            return .appleStandTime
        case "distanceWalkingRunning":
            return .distanceWalkingRunning
        case "stepCount":
            return .stepCount
        default:
            return .stepCount
        }
    }

}
        
        
        
        






    
