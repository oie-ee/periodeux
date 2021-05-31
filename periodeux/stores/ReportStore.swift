//
//  ReportStore.swift
//  periodeux


import Foundation
import RealmSwift
import SwiftUI
import CoreLocation

final class ReportStore: ObservableObject {
    private var results: Results<ReportDB>
    
    var reports: [Report] {
        results.map(Report.init)
    }
    
    
    
    // Load Items from the Realm Database
    init(realm: Realm) {
        results = realm.objects(ReportDB.self)
    }
    
    
    
    func findByID (id: Int) -> ReportDB! {
        do {
            return try Realm().object(ofType: ReportDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension ReportStore {
    func create(date: Date, moodType: String, moodAction: Action, symptomType: String, symptomAction: Action, bleeding: Int? = nil) {
        
        objectWillChange.send()
        
        print("MOODACTION \(moodAction)")
        
        
        // Escape for update rather than create a new report,
        // if the report is already existing
        let reportID = self.getExistingReportID(date: date)
        
        if(reportID != 0) {
            self.update(
                reportID: reportID,
                date: date,
                moodType: moodType,
                moodAction: moodAction,
                symptomType: symptomType,
                symptomAction: symptomAction,
                bleeding: bleeding
            
            )
            return
        }
        
        do {
            let realm = try Realm()
            
            let refDB = ReportDB()
            
            let id = UUID().hashValue
            refDB.id = id
            refDB.name = moodType
            refDB.date = date
            refDB.bleeding = Int.min
           
            
            if(!moodType.isEmpty) {
                refDB.moodList.append(moodType)
            }
            
            if(!symptomType.isEmpty) {
                refDB.symptomList.append(symptomType)
            }
         
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func update(reportID: Int, date: Date, moodType: String, moodAction: Action, symptomType: String, symptomAction: Action, bleeding: Int? = nil) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        let previousReport = self.findByID(id: reportID)!
                
        do {
            let realm = try Realm()
            
            try realm.write {
                let updatedReport = ReportDB()
                updatedReport.id = reportID
                
                let newMoodList = self.updateList(report: previousReport, action: moodAction, type: moodType)
                let newSymptomList = self.updateSymptomList(report: previousReport, action: symptomAction, type: symptomType)
                
                if(bleeding == nil) {
                    updatedReport.bleeding = previousReport.bleeding
                }else {
                    updatedReport.bleeding = bleeding!
                }
                
                updatedReport.id = reportID
                updatedReport.date = date
                //updatedReport.bleeding = bleeding!
                updatedReport.moodList = newMoodList
                updatedReport.symptomList = newSymptomList
                
                realm.add(updatedReport, update: .modified)
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
    
    func getExistingReportID(date: Date) -> Int {
        print("SELECTED DATE \(date)")
        
        // Returns the ReportID if the Dates are matching
        for report in self.reports {
            if(self.checkDatesForSameDay(firstDate: report.date, secondDate: date)) {
                return report.id
            }
        }
                
        return 0
    }
    
    func checkDatesForSameDay(firstDate: Date, secondDate: Date) -> Bool {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let a = formatter.string(from: firstDate)
        let b = formatter.string(from: secondDate)
        
        if(a == b) {
            return true
        }
        
        return false
    }
    
    func updateList (report: ReportDB, action: Action, type: String) -> RealmSwift.List<String> {
        // Append new Items to MoodList
        var newMoodList : RealmSwift.List<String>
        newMoodList = report.moodList
        
        if(type.isEmpty) {
            return newMoodList
        }
        
        if(action == .add) {
            newMoodList.append(type)
        }
        
        if (action == .remove) {
            let index = newMoodList.index(of: type) ?? Int.max
            
            if(index != Int.max) {
                newMoodList.remove(at: index)
            }
        }
        
        return newMoodList
    }
    
    func updateSymptomList (report: ReportDB, action: Action, type: String) -> RealmSwift.List<String> {
        // Append new Items to symptomList
        var newSymptomList : RealmSwift.List<String>
        newSymptomList = report.symptomList
        
        if(type.isEmpty) {
            return newSymptomList
        }
        
        if(action == .add) {
            newSymptomList.append(type)
        }
        
        if (action == .remove) {
            let index = newSymptomList.index(of: type) ?? Int.max
            
            if(index != Int.max) {
                newSymptomList.remove(at: index)
            }
        }
        
        return newSymptomList
    }
}

