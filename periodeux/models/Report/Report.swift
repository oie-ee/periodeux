
import Foundation
import SwiftUI
import RealmSwift

struct Report: Identifiable, Hashable {
    let id          : Int
    let name        : String
    let date        : Date
    let reportID    : Int
    let moodList    : RealmSwift.List<String>
    let symptomList : RealmSwift.List<String>
    //bleeding fehlt
}

extension Report {
    
    init(reportDB: ReportDB) {
        id              = reportDB.id
        name            = reportDB.name
        date            = reportDB.date
        reportID        = reportDB.reportID
        moodList        = reportDB.moodList
        symptomList     = reportDB.symptomList
        //bleeding fehlt
    }
}
