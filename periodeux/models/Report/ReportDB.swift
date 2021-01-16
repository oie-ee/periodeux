
import Foundation
import RealmSwift
import SwiftUI

class ReportDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var reportID = 0
    
    //Defines the standard key – realm needs this for identification
    override static func primaryKey() -> String? {
        "id"
    }
    
}
