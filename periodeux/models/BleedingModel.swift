import Foundation

//MARK –  BleedingModel
struct BleedingModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension BleedingModel {
    
    static var bleeding1 = BleedingModel(name: "No Bleeding", imageIcon: "app.fill")
    static var bleeding2 = BleedingModel(name: "Strong", imageIcon: "app.fill")
}

let dummyBleedingData = [BleedingModel.bleeding1]
