//
//  RealmPersistentInitializer.swift
//  periodeux
//
//  Created by Felix Tesche on 15.05.21.
//

import Foundation
import RealmSwift
import Realm

class RealmPersistent {
    static func initializer() -> Realm {
        do {
            let realm = try Realm()
            print("Successsssfully connected to RealmDB")
            return realm
        }
        catch let err {
            fatalError("Failed to open Realm \(err.localizedDescription)")
        }
    }
}
