//this is a small Icon and Title display for InfoInputView

import SwiftUI

struct SmallSymptomCellView: View {
    
    
    var symptom: SymptomModel
    
    var body: some View {
        
        VStack{
            Button(action: {
                print("\(symptom.name) was selected")
            }, label: {
                
                VStack{
                    Image("\(symptom.imageIcon):44x44")
                    
                    Text(symptom.name)
                        .font(.caption2)
                        .foregroundColor(.black)
                }
            })
        }
    }
}
struct SymptomRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallSymptomCellView(symptom: SymptomModel.symptom2)
    }
}





