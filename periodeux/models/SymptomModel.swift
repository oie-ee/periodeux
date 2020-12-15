import Foundation

//MARK –  SymptomModel
struct SymptomModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
}

extension SymptomModel {
    
    static var symptom1 =  SymptomModel(name: "All Is Well", imageIcon: "app.fill")
    static var symptom2 =  SymptomModel(name: "Cramps", imageIcon: "app.fill")
    static var symptom3 =  SymptomModel(name: "Sensitive Breast", imageIcon: "app.fill")
    static var symptom4 =  SymptomModel(name: "Headache", imageIcon: "app.fill")
    static var symptom5 =  SymptomModel(name: "Acne", imageIcon: "app.fill")
    static var symptom6 =  SymptomModel(name: "Lower Back Pain", imageIcon: "app.fill")
    static var symptom7 =  SymptomModel(name: "Nausea", imageIcon: "app.fill")
    static var symptom8 =  SymptomModel(name: "Tiredness", imageIcon: "app.fill")
    static var symptom9 =  SymptomModel(name: "Flatulence", imageIcon: "app.fill")
    static var symptom10 = SymptomModel(name: "Ravenous Appetite", imageIcon: "app.fill")
    static var symptom11 = SymptomModel(name: "Insomnia", imageIcon: "app.fill")
    static var symptom12 = SymptomModel(name: "Constipation", imageIcon: "app.fill")
    static var symptom13 = SymptomModel(name: "Diarrhea", imageIcon: "app.fill")
    
}

let dummySymptomData = [SymptomModel.symptom1, SymptomModel.symptom2, SymptomModel.symptom3]
