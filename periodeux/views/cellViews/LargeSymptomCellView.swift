
// MARK: - LargeSymptomCellView
//this is a larger Icon and Title display for the detailed ModalInfoView

import SwiftUI

struct LargeSymptomCellView: View {
    
    var symptom: SymptomModel
    @State var isSelected : Bool
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var symptoms: [SymptomModel] = symptomModel
    
    // MARK: - Body
    var body: some View {
        
        Button(action: {
            print("\(symptom.name) was selected")
            
            // HOOK Save Report
            var action : Action
            
            if(isSelected) {
                action = Action.remove
            } else {
                action = Action.add
            }
            
            isSelected.toggle()
            
            reportStore.create(date: appStore.selectedDate, moodType: "", moodAction: action, symptomType: symptom.name, symptomAction: action, bleeding: nil)
            
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image("\(symptom.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(ColorManager.highlightOrange, lineWidth: 3)
                        )
                }else {
                    Image("\(symptom.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(Color.clear, lineWidth: 3)
                        )
                }
                
                Text(symptom.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .frame(width: 80, height: 48, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        })
    }
}
