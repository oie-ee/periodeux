
import SwiftUI

struct LargeSymptomCellView: View {
    
    var symptom: SymptomModel
    @State var isSelected = false
    
    var body: some View {
        
        Button(action: {
            print("\(symptom.name) was selected")
            isSelected.toggle()
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image(systemName: symptom.imageIcon)
                        .resizable()
                        .frame(width: 68, height: 68)
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(ColorManager.highlightOrange, lineWidth: 4)
                        )
                }else {
                    Image(systemName: symptom.imageIcon)
                        .resizable()
                        .frame(width: 68, height: 68)
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.clear, lineWidth: 4)
                        )
                }
                
                Text(symptom.name)
                    .font(.callout)
                    .foregroundColor(.black)
                    .frame(width: 80, height: 48)
                    .multilineTextAlignment(.center)
            }
        })
    }
}

struct LargeSymptomCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeSymptomCellView(symptom: SymptomModel.symptom1)
    }
}
