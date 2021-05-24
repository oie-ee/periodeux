import Foundation

// MARK: - Mood Model
struct MoodModel: Identifiable {
    var id = UUID()
    var name: String
    var imageIcon: String
    
}

extension MoodModel {
    
    static var mood1  = MoodModel(name: "Relaxed", imageIcon: "mood:relaxed")
    static var mood2  = MoodModel(name: "Happy", imageIcon: "mood:happy")
    static var mood3  = MoodModel(name: "Energetic", imageIcon: "mood:energetic")
    static var mood4  = MoodModel(name: "Playful", imageIcon: "mood:playful")
    static var mood5  = MoodModel(name: "Mood Swings", imageIcon: "mood:moodswing")
    static var mood6  = MoodModel(name: "Irritable", imageIcon: "mood:irritable")
    static var mood7  = MoodModel(name: "Sad", imageIcon: "mood:sad")
    static var mood8  = MoodModel(name: "Anxious", imageIcon: "mood:anxious")
    static var mood9  = MoodModel(name: "Depressed", imageIcon: "mood:depressed")
    static var mood10 = MoodModel(name: "Feeling Guilty", imageIcon: "mood:feelingGuilty")
    static var mood11 = MoodModel(name: "Obsessive Thoughts", imageIcon: "mood:obsessiveThoughts")
    static var mood12 = MoodModel(name: "Listless", imageIcon: "app.fill")
    static var mood13 = MoodModel(name: "Distracted", imageIcon: "mood:distracted")
    static var mood14 = MoodModel(name: "Very Self-Critical", imageIcon: "app.fill")
    
}

let moodModel = [MoodModel.mood8, MoodModel.mood9, MoodModel.mood13, MoodModel.mood3, MoodModel.mood10, MoodModel.mood2, MoodModel.mood6, MoodModel.mood5, MoodModel.mood11, MoodModel.mood4, MoodModel.mood1, MoodModel.mood7]

