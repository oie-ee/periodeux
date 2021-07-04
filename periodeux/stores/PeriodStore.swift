//
//  ReportStore.swift
//  periodeux


import Foundation
import RealmSwift
import SwiftUI
import CoreLocation


final class PeriodStore: ObservableObject {
    
    @AppStorage("isCycleDuration") private var isCycleDuration = 21
    @AppStorage("isFirstPeriod") private var isFirstPeriod: Date = Date()
    @AppStorage("isPeriodDuration") private var isPeriodDuration = 7
    
    private var results: Results<PeriodDB>
    
    var periods: [Period] {
        let array = results.map(Period.init)
        
        return [Period(id: 0, date: isFirstPeriod.startOfDay() ?? isFirstPeriod, durationDays: isPeriodDuration)] + array
        
    }
    
    /// Gets the last period from Store relative to the given date
    /// - Parameter date: a date
    /// - Returns: a period
    func getLatestPeriodFromDate(date: Date?) -> Period? {
        guard date != nil else {
            return nil
        }
        
        let periodsOrderedByDate = self.periods.sorted { periodA, periodB in
            periodA.date > periodB.date
        }
        
        return periodsOrderedByDate.first { period in
            return period.date <= date!
        }
    }
    
    /// Gets the next period from Store relative to the given date
    /// - Parameter date: a date
    /// - Returns: a period
    func getNextPeriodFromDate(date: Date?) -> Period? {
        
        guard date != nil else {
            return nil
        }
        
        let periodsOrderedByDate = self.periods.sorted { periodA, periodB in
            periodA.date < periodB.date
        }
        
        return periodsOrderedByDate.first { period in
            return period.date > date!
        }
    }
    
    /// Calculates the next occurance of a given period, calculated with the average cycle duration
    /// - Parameter period: given period
    /// - Returns: a new period instance with id: 0 and a average duration
    func getNextOccurenceOfPeriod(_ period: Period) -> Period {
        return Period(id: 0, date: period.endDate + self.averageCycleDuration, durationDays: self.averagePeriodDuration)
    }
    
    /// Gets all periods for the given month
    /// - Parameter date: date within a month
    /// - Returns: array of periods
    func getPeriodsForMonthOfDate(_ date: Date) -> [Period] {
        let startOfMonth = date.startOfMonth()
        
        guard startOfMonth != nil else {
            return []
        }
        
//        Gets the last period and calculates the nearest occurence, relative to the start of the month
        var lastPeriod = self.getLatestOccurenceOfPeriodForDate(
            period: self.getLatestPeriodFromDate(
                date: startOfMonth
            ),
            startOfMonth!
        )
        
//        if there was no period before the start of the month, find a period after the start of the month
        lastPeriod = lastPeriod ?? self.getNextPeriodFromDate(date: startOfMonth)
        
        guard lastPeriod != nil else {
            return []
        }
        
//        create a array for all month periods
//        if the last period is not within the month of the given date -> empty array, if not, add the last period to the array
        var periodArray: [Period] = Calendar.current.isDate(lastPeriod!.date, equalTo: startOfMonth!, toGranularity: .month) ? [lastPeriod!] : []
        
        while true {
//            get the next period after the last ended or calculate the next occurenc fo the last period
            let nextPeriod = self.getNextPeriodFromDate(date: lastPeriod!.date) ?? self.getNextOccurenceOfPeriod(lastPeriod!)
            
//            if the next period is not within dates month, cancel loop
            if !Calendar.current.isDate(startOfMonth!, equalTo: nextPeriod.date, toGranularity: .month) {
                break
            }
            
            periodArray.append(nextPeriod)
            lastPeriod = nextPeriod
        }

        return periodArray
       
    }
    

    
    /// Calculates the average duration of a period, according to the past periods from the store
    var averagePeriodDuration: Int {
        return isPeriodDuration
    }
    
    
    /// Calculates the average cycle duration of a period, according to the past periods from the store
    var averageCycleDuration: TimeInterval {
        return Double(isCycleDuration)*3600.00*24.00
    }
    
    
    /// Gets the latest reappearence (occurence) of a period in the past, relativ to the given date
    /// calculates with the average cycle duration
    /// - Parameters:
    ///   - period: the given period
    ///   - date: the date
    /// - Returns: the periods latest occurence
    func getLatestOccurenceOfPeriodForDate(period: Period?, _ date: Date) -> Period? {
        
        guard period != nil else {
            return nil
        }
        
        
        let absoluteDistanceToPeriod = period!.date.distance(to: date)
        
//        in case the period is after the given date
        guard absoluteDistanceToPeriod >= 0 else {
            return nil
        }
        
        
        let distanceFromPeriodOccurence = Int(absoluteDistanceToPeriod) % Int(self.averageCycleDuration)
        
        let periodOccurence = Period(id: 0, date: (date - TimeInterval(distanceFromPeriodOccurence)), durationDays: self.averagePeriodDuration)
        
        return periodOccurence
    }
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(PeriodDB.self)
    }
    
    
    
    func findByID (id: Int) -> PeriodDB! {
        do {
            return try Realm().object(ofType: PeriodDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension PeriodStore {
    func create(date: Date, duration: DateInterval?) {
        
        objectWillChange.send()
        
        
        do {
            let realm = try Realm()
            
            let refDB = PeriodDB()
            
            let id = UUID().hashValue
            refDB.id = id
         
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func update(id: Int, date: Date, durationDays: Int) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
//        let periodForUpdate = self.findByID(id: id)
                
        do {
            let realm = try Realm()
            
            try realm.write {
                let updatedPeriod = PeriodDB()
                updatedPeriod.id = id
                updatedPeriod.date = date
                updatedPeriod.durationDays = durationDays
                
                realm.add(updatedPeriod, update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            indexSet.forEach ({ index in
                try! realm.write {
                    realm.delete(self.results[index])
                }
            })
        } catch let err {
            print(err.localizedDescription)
        }
    }
    

}
