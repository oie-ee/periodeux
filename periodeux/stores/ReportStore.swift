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
    func create(name: String, date: Date) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let refDB = ReportDB()
            
            let id = UUID().hashValue
            refDB.id = id
            refDB.name = name
            refDB.date = date
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    func update(venueID: Int, venueName: String, venueLocation: String, venueStreet: String, venueCountry: String) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(ReportDB.self,
                             value: [
//                                VenueDBKeys.id.rawValue: venueID,
//                                VenueDBKeys.name.rawValue: venueName,
//                                VenueDBKeys.location.rawValue: venueLocation,
//                                VenueDBKeys.street.rawValue: venueStreet,
//                                VenueDBKeys.country.rawValue: venueCountry
                             ],
                             update: .modified)
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

