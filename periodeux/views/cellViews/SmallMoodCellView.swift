
//this is a small Icon and Title display for InfoInputView

import SwiftUI

struct SmallMoodCellView: View {

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
                        Image("\(mood.imageIcon):44x44")
                        
                    } else {
                        Image("\(mood.imageIcon):44x44")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
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
