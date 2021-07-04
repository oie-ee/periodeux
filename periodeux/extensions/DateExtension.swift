//
//  DateExtension.swift
//  periodeux
//
//  Created by Gustav on 04.07.21.
//

import Foundation

extension Date {
    func startOfMonth() -> Date? {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: comp)!
    }
    
    func startOfDay() -> Date? {
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return Calendar.current.date(from: comp)!
    }
    
    func endOfMonth() -> Date? {
        guard self.startOfMonth() != nil else {
            return nil
        }
        
        var comp = DateComponents()
        comp.month = 1
        comp.day = -1
        return Calendar.current.date(byAdding: comp, to: self.startOfMonth()!)
    }
    
    static func dateFromComponents(day: Int, month: Int, year: Int) -> Date? {
        
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components)
    }
}
