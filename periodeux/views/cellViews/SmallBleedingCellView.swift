
// MARK: - SmallBleedingCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallBleedingCellView: View {
    
    @State var showingModalView = false
    @State var selectedDiaryTag: Int
    @Binding var parentState: Int
    
    var bleeding: BleedingModel
    
    var body: some View {
        
        Button(action: {
            self.showingModalView.toggle()
            parentState = selectedDiaryTag
            
        }) {
            
            VStack{
                
                Image("\(bleeding.imageIcon):44x44")
                
                Text(bleeding.name)
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
