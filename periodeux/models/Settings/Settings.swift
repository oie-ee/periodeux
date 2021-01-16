
import Foundation
import SwiftUI
import RealmSwift

struct Settings: Identifiable, Hashable {
    
    let id                    : Int
    let lengthOfCycle         : Int
    let lengthOfPeriod        : Int
    let startOfPeriod         : Date
   
}

extension Settings {
    
    init(settingsDB: SettingsDB) {
    
    id                       = settingsDB.id
    lengthOfCycle            = settingsDB.lengthOfCycle
    lengthOfPeriod           = settingsDB.lengthOfPeriod
    startOfPeriod            = settingsDB.startOfPeriod
        
    }
}
