
// MARK: - SmallSymptomCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallSymptomCellView: View {
    
    @State var showingModalView = false
    @State var selectedDiaryTag: Int
    @Binding var parentState: Int
    
    var symptom: SymptomModel
    
    var body: some View {
        
        Button(action: {
            self.showingModalView.toggle()
            parentState = selectedDiaryTag
            
        }) {
            
            VStack{
                
                Image("\(symptom.imageIcon):44x44")
                
                Text(symptom.name)
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
