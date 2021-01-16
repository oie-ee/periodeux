//
//  AppStore.swift
//  periodeux
//
//  Created by Felix Tesche on 16.01.21.
//

import Foundation


class AppStore: ObservableObject {
    @Published var selectedDate : Date
    
    init() {
        self.selectedDate = Date()
    }
}
