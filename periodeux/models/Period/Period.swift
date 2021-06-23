
import Foundation
import RealmSwift

struct Period: Identifiable, Hashable {
    
    let id          : Int
    let date        : Date
    let duration    : TimeInterval
    
    var endDate: Date {
        return self.date.addingTimeInterval(self.duration)
    }
    
    var periodInterval: DateInterval {
        return DateInterval(start: self.date, duration: self.duration)
    }
    
    func isDatePeriodStartDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(self.date, inSameDayAs: date)
    }
    
    func isDateInPeriodInterval(_ date: Date) -> Bool {
        return self.periodInterval.contains(date)
    }
    
    func isDatePeriodEndDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(self.endDate, inSameDayAs: date)
    }
   
}

extension Period {
    
    init(periodDB: PeriodDB) {
        id              = periodDB.id
        date            = periodDB.date
        duration        = periodDB.duration

    }
}
