
import Foundation
import RealmSwift

struct Period: Identifiable, Hashable {
    let id          : Int
    let date        : Date
    let duration    : TimeInterval
   
}

extension Period {
    
    init(periodDB: PeriodDB) {
        id              = periodDB.id
        date            = periodDB.date
        duration        = periodDB.duration

    }
}
