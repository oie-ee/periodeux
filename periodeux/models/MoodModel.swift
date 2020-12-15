import Foundation

// MARK: MoodModel
struct MoodModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
    
}

extension MoodModel {
    
    static var mood1 =  MoodModel(name: "Relaxed", imageIcon: "app.fill")
    static var mood2 =  MoodModel(name: "Happy", imageIcon: "app.fill")
    static var mood3 =  MoodModel(name: "Energetic", imageIcon: "app.fill")
    static var mood4 =  MoodModel(name: "Playful", imageIcon: "app.fill")
    static var mood5 =  MoodModel(name: "Mood Swings", imageIcon: "app.fill")
    static var mood6 =  MoodModel(name: "Irritable", imageIcon: "app.fill")
    static var mood7 =  MoodModel(name: "Sad", imageIcon: "app.fill")
    static var mood8 =  MoodModel(name: "Anxious", imageIcon: "app.fill")
    static var mood9 =  MoodModel(name: "Depressed", imageIcon: "app.fill")
    static var mood10 = MoodModel(name: "Feeling Guilty", imageIcon: "app.fill")
    static var mood11 = MoodModel(name: "Obsessive Thoughts", imageIcon: "app.fill")
    static var mood12 = MoodModel(name: "Listless", imageIcon: "app.fill")
    static var mood13 = MoodModel(name: "Distracted", imageIcon: "app.fill")
    static var mood14 = MoodModel(name: "Very Self-Critical", imageIcon: "app.fill")
    
}

let dummyMoodData = [MoodModel.mood1, MoodModel.mood2, MoodModel.mood3, MoodModel.mood4]
