
import SwiftUI

struct SmallMoodCellView: View {
    
    @State var showingModalView = false
    @State var isSelected = false
    
    var mood: MoodModel
    
    var body: some View {
        
        VStack{
            Button(action: {
                print("\(mood.name) was selected")
                isSelected.toggle()
            }, label: {
                VStack{
                    
                    if(isSelected) {
                        Image(systemName: mood.imageIcon)
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                        // Border Klimmbimm
                    } else {
                        Image(systemName: mood.imageIcon)
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                        // Border Klimmbimm
                    }
                    
                    
                    Text(mood.name)
                        .font(.caption2)
                        .foregroundColor(.black)
                }
            })
        }
    }
}


struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallMoodCellView(mood: MoodModel.mood1)
    }
}
