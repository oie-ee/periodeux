
import Foundation
import RealmSwift


class PeriodDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var date = Date()
    @objc dynamic var durationDays: Int = 0

    
    //Defines the standard key – realm needs this for identification
    override static func primaryKey() -> String? {
        "id"
    }
    
}
