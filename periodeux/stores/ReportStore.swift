//
//  ReportStore.swift
//  periodeux
//
//  Created by Felix Tesche on 15.05.21.
//

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
    func create(date: Date, moodType: String, moodAction: Action) {
        
        objectWillChange.send()
        
        print("MOODACTION \(moodAction)")
        
        
        // Escape for update rather than create a new report,
        // if the report is already existing
        let reportID = self.getExistingReportID(date: date)
        
        if(reportID != 0) {
            self.update(reportID: reportID, date: date, moodType: moodType, moodAction: moodAction)
            return
        }
        
        do {
            let realm = try Realm()
            
            let refDB = ReportDB()
            
            let id = UUID().hashValue
            refDB.id = id
            refDB.name = moodType
            refDB.date = date
            refDB.moodList.append(moodType)
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func update(reportID: Int, date: Date, moodType: String, moodAction: Action) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        let report = self.findByID(id: reportID)!
                
        do {
            let realm = try Realm()
            
            try realm.write {
                let updatedReport = ReportDB()
                
                let newMoodList = self.updateList(report: report, action: moodAction, type: moodType)
                
                updatedReport.id = reportID
                updatedReport.date = date
                updatedReport.moodList = newMoodList
                
                
                
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
}

