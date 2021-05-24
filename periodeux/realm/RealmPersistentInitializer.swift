//
//  RealmPersistentInitializer.swift
//  periodeux


import Foundation
import RealmSwift
import Realm

class RealmPersistent {
    static func initializer() -> Realm {
        do {
            let realm = try Realm()
            print("Successfully connected to RealmDB")
            return realm
        }
        catch let err {
            fatalError("Failed to open Realm \(err.localizedDescription)")
        }
    }
}
