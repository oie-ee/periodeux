
import Foundation
import RealmSwift

struct Period: Identifiable, Hashable {
    
    let id              : Int
    let date            : Date
    let durationDays    : Int
    
    var endDate: Date {
        return Calendar.current.date(byAdding: .day, value: durationDays-1, to: self.date) ?? self.date
    }
    
    var periodInterval: DateInterval {
        return DateInterval(start: self.date, end: self.endDate)
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
        id                  = periodDB.id
        date                = periodDB.date
        durationDays        = periodDB.durationDays

    }
}
