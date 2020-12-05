
import SwiftUI

struct SymptomRowView: View {
    var symptom: SymptomModel
    
    var body: some View {
       
        HStack {
            
            VStack{
                
                Image(systemName: symptom.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)
                
                Text(symptom.name)
                    .font(.caption2)
            }
        }
    }
}

struct SymptomRowView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomRowView(symptom: SymptomModel.symptom2)
    }
}
