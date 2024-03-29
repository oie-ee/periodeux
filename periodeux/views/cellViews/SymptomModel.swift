import Foundation

// MARK: - Symptom Model
struct SymptomModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension SymptomModel {
    
    static var symptom1  = SymptomModel(name: "All Is Well", imageIcon: "symptom:alliswell")
    static var symptom2  = SymptomModel(name: "Cramps", imageIcon: "symptom:cramps")
    static var symptom3  = SymptomModel(name: "Sensitive Breasts", imageIcon: "symptom:sensitivebreasts")
    static var symptom4  = SymptomModel(name: "Headache", imageIcon: "symptom:headache")
    static var symptom5  = SymptomModel(name: "Acne", imageIcon: "symptom:acne")
    static var symptom6  = SymptomModel(name: "Lower Back Pain", imageIcon: "symptom:lowerbackpain")
    static var symptom7  = SymptomModel(name: "Nausea", imageIcon: "symptom:nausea")
    static var symptom8  = SymptomModel(name: "Tiredness", imageIcon: "symptom:tiredness")
    static var symptom9  = SymptomModel(name: "Flatulence", imageIcon: "symptom:flatulence")
    static var symptom10 = SymptomModel(name: "Ravenous Appetite", imageIcon: "symptom:ravenousappetite")
    static var symptom11 = SymptomModel(name: "Insomnia", imageIcon: "symptom:insomnia")
    static var symptom12 = SymptomModel(name: "Constipa-\ntion", imageIcon: "symptom:constipa-tion")
    static var symptom13 = SymptomModel(name: "Diarrhea", imageIcon: "symptom:diarrhea")
}

let symptomModel = [SymptomModel.symptom5, SymptomModel.symptom1, SymptomModel.symptom12, SymptomModel.symptom2, SymptomModel.symptom13, SymptomModel.symptom9, SymptomModel.symptom4, SymptomModel.symptom11, SymptomModel.symptom6, SymptomModel.symptom7, SymptomModel.symptom10, SymptomModel.symptom3, SymptomModel.symptom8]
