//
//  ReportStore.swift
//  periodeux


import Foundation
import RealmSwift
import SwiftUI
import CoreLocation

extension Date {
    func startOfMonth() -> Date? {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: comp)!
    }
    func endOfMonth() -> Date? {
        guard self.startOfMonth() != nil else {
            return nil
        }
        
        var comp = DateComponents()
        comp.month = 1
        return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
    }
}


final class PeriodStore: ObservableObject {
    
    @AppStorage("isCycleDuration") private var isCycleDuration = 21
    @AppStorage("isFirstPeriod") private var isFirstPeriod: Date = Date()
//    var isFirstPeriod: Date = Date()
    
    @AppStorage("isPeriodDuration") private var isPeriodDuration = 7
    
    private var results: Results<PeriodDB>
    
    var periods: [Period] {
        results.map(Period.init)
    }
    
    func getLatestPeriodFromDate(date: Date) -> Period {
        return periods.first { period in
            return period.date <= date
        } ?? Period(id: 0, date: Calendar.current.startOfDay(for: isFirstPeriod), durationDays: averagePeriodDuration)
    }
    
    func getPeriodsForMonthOfDate(_ date: Date) -> [Period] {
        let startOfMonth = Calendar.current.date(bySetting: .day, value: 1, of: date) ?? date
        
//        print(date.startOfMonth(), date.endOfMonth())
        
//        let latestPeriodFromDate = self.getLatestPeriodFromDate(date: startOfMonth)
        
//        let latestOccurenceOfLatestPeriod = self.getLatestOccurenceOfPeriodForDate(period: latestPeriodFromDate, startOfMonth)
        
        let periodsCollection = periods.filter { period in
            Calendar.current.isDate(period.date, equalTo: startOfMonth, toGranularity: .month)
        }
        
//        print("getPeriodsForMonthOfDate:", latestOccurenceOfLatestPeriod)
        
        return periodsCollection
       
    }
    
    var averagePeriodDuration: Int {
        return isPeriodDuration
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

