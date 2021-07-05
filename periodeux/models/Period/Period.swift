
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
    
    var ovulationDate: Date {
        return Calendar.current.date(byAdding: .day, value: -14, to: self.date) ?? self.date
    }
    
    var fertileInterval: DateInterval {
        return DateInterval(start: fertileStartDate, end: self.ovulationDate)
    }
    
    var fertileStartDate: Date {
        return Calendar.current.date(byAdding: .day, value: -5, to: self.ovulationDate) ?? self.ovulationDate
    }
    
    func isDateFertileStart(_ date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: fertileStartDate)
    }
    
    func isDateFertile(_ date: Date) -> Bool {
        return self.fertileInterval.contains(date)
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
    
    func isOvulationDate(_ date: Date) -> Bool {
        return Calendar.current.isDate(self.ovulationDate, inSameDayAs: date)
    }
    
    
   
}

extension Period {
    
    init(periodDB: PeriodDB) {
        id                  = periodDB.id
        date                = periodDB.date
        durationDays        = periodDB.durationDays

    }
}
