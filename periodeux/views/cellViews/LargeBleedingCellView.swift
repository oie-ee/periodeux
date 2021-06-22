

// MARK: - LargeBleedingCellView
//this is a larger Icon and Title display for the detailed ModalInfoView

import SwiftUI

struct LargeBleedingCellView: View {
    
    var bleeding: BleedingModel
    var isSelected : Bool {
        if(isActive[index] == true) {
            return true
        } else {
            return false
        }
    }
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @Binding var isActive : [Bool]
    
    @State var index : Int
    
    // MARK: - Body
    var body: some View {
        
        Button(action: {
            print("\(bleeding.name) was selected")
            
            isActive = [false, false, false, false]
            isActive[index] = true
            
            reportStore.create(
                date: appStore.selectedDate,
                moodType: "",
                moodAction: .none ,
                symptomType: "",
                symptomAction: .none,
                bleeding: self.convertBleedingTypeToInteger(type: bleeding.name)
            )
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image("\(bleeding.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(ColorManager.highlightOrange, lineWidth: 3)
                        )
                }else {
                    Image("\(bleeding.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.clear, lineWidth: 3)
                        )
                }
                
                Text(bleeding.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .frame(width: 80, height: 48, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        })
    }
    
    func convertBleedingTypeToInteger (type: String) -> Int {
        if(type == "No Bleeding") { return 0 }
        
        if(type == "Light") { return 1 }
        
        if(type == "Regular") { return 2 }
        
        if(type == "Heavy") { return 3 }
        
        return Int.min
    }

}

