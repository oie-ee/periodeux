
import SwiftUI

struct SymptomRowView: View {
    
    @State var showingModalView = false
    
    
    var symptom: SymptomModel
    
    var body: some View {
       
        HStack {
            
            VStack{
            Button(action: {
       self.showingModalView.toggle()
           }, label: {
      
            VStack{
                Image(systemName: symptom.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)
                
                Text(symptom.name)
                    .font(.caption2)
                    .foregroundColor(Color(UIColor(named: "highlightOrange")!))
                              }
                          })
                      }
                  }
                  .sheet(isPresented: $showingModalView) {
                      ModalInfoView()
                  
    
              }
    }
}
struct SymptomRowView_Previews: PreviewProvider {
    static var previews: some View {
        SymptomRowView(symptom: SymptomModel.symptom2)
    }
}





