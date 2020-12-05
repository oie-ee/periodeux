
import SwiftUI

struct MoodRowView: View {
    var mood: MoodModel
    
    var body: some View {
       
        HStack {
            
            VStack{
                
                Image(systemName: mood.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)
                
                Text(mood.name)
                    .font(.caption2)
            }
        }
    }
}

struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRowView(mood: MoodModel.mood1)
    }
}
