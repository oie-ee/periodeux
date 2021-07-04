//
//  ReportStore.swift
//  periodeux


import Foundation
import RealmSwift
import SwiftUI
import CoreLocation

final class PeriodStore: ObservableObject {
    @AppStorage("isFirstPeriod") private var isFirstPeriod = Date()
    @AppStorage("isCycleDuration") private var isCycleDuration = 21
    @AppStorage("isPeriodDuration") private var isPeriodDuration = 7
    
    private var results: Results<PeriodDB>
    
    var periods: [Period] {
        results.map(Period.init)
    }
    
    func getLatestPeriodFromDate(date: Date) -> Period {
        return periods.first { period in
            return period.date <= date
        } ?? Period(id: 0, date: Calendar.current.startOfDay(for: isFirstPeriod), duration: averagePeriodDurationMinusDay)
    }
    
    var averagePeriodDuration: TimeInterval {
        return Double(isPeriodDuration)*3600.00*24.00
    }
    
    var averagePeriodDurationMinusDay: TimeInterval {
        let day = 3600.00*24.00
        return averagePeriodDuration - day
    }
    
    var averageCycleDuration: TimeInterval {
        return Double(isCycleDuration)*3600.00*24.00
    }
    
    func getLatestOccurenceOfPeriodForDate(period: Period, _ date: Date) -> Period? {
        
        let absoluteDistanceToPeriod = period.date.distance(to: date)
        
        
        guard absoluteDistanceToPeriod >= 0 else {
            return nil
        }
        
        let distanceFromPeriodOccurence = Int(absoluteDistanceToPeriod) % Int(self.averageCycleDuration)
        
//        print(date, distanceFromPeriodOccurence, period.date)
        
        let periodOccurence = Period(id: 0, date: (date - TimeInterval(distanceFromPeriodOccurence)), duration: self.averagePeriodDurationMinusDay)
        
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
    
    func update(id: Int, date: Date, duration: TimeInterval) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        let periodForUpdate = self.findByID(id: id)!
                
        do {
            let realm = try Realm()
            
            try realm.write {
                let updatedPeriod = PeriodDB()
                updatedPeriod.id = id
                updatedPeriod.date = date
                updatedPeriod.duration = duration
                
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

