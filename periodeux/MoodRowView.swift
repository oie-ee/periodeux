
import SwiftUI

struct MoodRowView: View {
    
    @State var showingModalView = false

    
    var mood: MoodModel
    
    var body: some View {
       
        HStack {
            
            VStack{
                Button(action: {
                    self.showingModalView.toggle()
                }, label: {
                    VStack{
                Image(systemName: mood.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)
                
                Text(mood.name)
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


struct MoodRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoodRowView(mood: MoodModel.mood1)
    }
}
