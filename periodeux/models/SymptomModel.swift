import Foundation

//MARK –  SymptomModel
struct SymptomModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension SymptomModel {
    
    static var symptom1 = SymptomModel(name: "Pain", imageIcon: "app.fill")
    static var symptom2 = SymptomModel(name: "Bloating", imageIcon: "app.fill")
    static var symptom3 = SymptomModel(name: "Fatigue", imageIcon: "app.fill")
}

let dummySymptomData = [SymptomModel.symptom1, SymptomModel.symptom2, SymptomModel.symptom3]
