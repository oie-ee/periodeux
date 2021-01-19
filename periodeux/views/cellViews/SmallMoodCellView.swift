
// MARK: - SmallMoodCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallMoodCellView: View {
    
    var mood: MoodModel
    
    var body: some View {
        
        VStack{
            
            Image("\(mood.imageIcon):44x44")
            
            Text(mood.name)
                .font(.caption2)
                .foregroundColor(.black)
                .frame(width: 50, height: 48, alignment: .top)
                .multilineTextAlignment(.center)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
    }
}


// MARK: - Preview
struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallMoodCellView(mood: MoodModel.mood1)
    }
}
