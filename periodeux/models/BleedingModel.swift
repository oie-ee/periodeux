import Foundation

//MARK –  BleedingModel
struct BleedingModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension BleedingModel {
    
    static var bleeding1 = BleedingModel(name: "No Bleeding", imageIcon: "app.fill")
    static var bleeding2 = BleedingModel(name: "Light", imageIcon: "app.fill")
    static var bleeding3 = BleedingModel(name: "Regular", imageIcon: "app.fill")
    static var bleeding4 = BleedingModel(name: "Heavy", imageIcon: "app.fill")
}

let dummyBleedingData = [BleedingModel.bleeding1, BleedingModel.bleeding2, BleedingModel.bleeding3, BleedingModel.bleeding4]
