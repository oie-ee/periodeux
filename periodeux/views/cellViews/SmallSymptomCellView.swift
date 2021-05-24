
// MARK: - SmallSymptomCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallSymptomCellView: View {
    
    var symptom: SymptomModel
    
    var body: some View {
        
        VStack{
            
            Image("\(symptom.imageIcon):44x44")
            
            Text(symptom.name)
                .font(.caption2)
                .foregroundColor(.black)
                .frame(width: 55, height: 30, alignment: .top)
                .multilineTextAlignment(.center)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
    }
}

// MARK: - Preview
struct SymptomRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallSymptomCellView(symptom: SymptomModel.symptom2)
    }
}
