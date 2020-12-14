import Foundation

// MARK: MoodModel
struct MoodModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
    
}

extension MoodModel {
    
    static var mood1 = MoodModel(name: "Happy", imageIcon: "app.fill")
    static var mood2 = MoodModel(name: "Sad", imageIcon: "app.fill")
    static var mood3 = MoodModel(name: "Hungry", imageIcon: "app.fill")
    static var mood4 = MoodModel(name: "Grumpy", imageIcon: "app.fill")
    
}

let dummyMoodData = [MoodModel.mood1, MoodModel.mood2, MoodModel.mood3, MoodModel.mood4]
