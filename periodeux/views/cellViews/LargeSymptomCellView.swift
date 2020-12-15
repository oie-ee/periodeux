
import SwiftUI

struct LargeSymptomCellView: View {
    
    var symptom: SymptomModel
    
    var body: some View {
        
        Button(action: {
            print("\(symptom.name) was selected")
        }, label: {
            
            VStack {
                
                Image(systemName: symptom.imageIcon)
                    .resizable()
                    .frame(width: 72, height: 72)
                    .foregroundColor(.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(ColorManager.highlightOrange, lineWidth: 4)
                    )
                
                Text(symptom.name)
                    .font(.body)
                    .foregroundColor(.black)
            }
        })
    }
}

struct LargeSymptomCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeSymptomCellView(symptom: SymptomModel.symptom1)
    }
}
