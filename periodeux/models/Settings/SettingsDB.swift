
import Foundation
import RealmSwift
import SwiftUI

class SettingsDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var lengthOfCycle = 0
    @objc dynamic var lengthOfPeriod = 0
    @objc dynamic var startOfPeriod = Date()
    
    //Defines the standard key – realm needs this for identification
    override static func primaryKey() -> String? {
        "id"
    }
    
}
