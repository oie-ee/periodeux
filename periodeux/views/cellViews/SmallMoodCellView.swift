
// MARK: - SmallMoodCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallMoodCellView: View {
    
    @State var showingModalView = false
    @State var selectedDiaryTag: Int
    @Binding var parentState: Int
    
    var mood: MoodModel
    
    var body: some View {
        
        Button(action: {
            self.showingModalView.toggle()
            parentState = selectedDiaryTag
            
        }) {
            
            VStack{
                
                Image("\(mood.imageIcon):44x44")
                
                Text(mood.name)
                    .font(.caption2)
                    .foregroundColor(.black)
                    .frame(width: 55, height: 30, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        }.sheet(isPresented: $showingModalView) {
            ModalInfoView(selectedDiaryTag: $parentState)
        }
    }
}
