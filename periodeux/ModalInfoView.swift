
import SwiftUI

struct ModalInfoView: View {
    @State var showingModalView = false
    @State var selectedDiaryTag: Int = 0
    @State var selectedDiary: String = "mood"

    
    var body: some View {
        
        VStack{
            Button(action: {
                showingModalView.toggle()
            }, label: {Text("done")
                .offset(x: 120, y: -190)
                .foregroundColor(Color(UIColor(named: "highlightOrange")!))
            })
            
        VStack {
          
            
            Picker("Language Picker", selection: $selectedDiaryTag) {
                Text("mood").tag(0)
                Text("symptom").tag(1)
                Text("bleeding").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .offset(x: 0, y: -200)
            .onChange(of: selectedDiaryTag, perform: {
                changedValue in
                
                if changedValue == 0 {
                    selectedDiary = "mood"
                }
                
                if changedValue == 1 {
                    selectedDiary = "symptom"
                }
                
                if changedValue == 2 {
                    selectedDiary = "bleeding"
                }
            })
        }
.edgesIgnoringSafeArea(.all)
    }
        
        VStack{
            
            if selectedDiaryTag == 0{
                
                mood()
            }
            
            if selectedDiaryTag == 1 {
                
                symptom()
            }
            
             if selectedDiaryTag == 2 {
                
                bleeding()
            }
            
        }
    
    }
}

struct ModalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalInfoView()
    }
}







struct mood : View {
    
    var body : some View{
        
        
                   
        VStack{
            
            Text("moods")
             
   
        }
              
    }
}


struct symptom : View {
    
    var body : some View{
        
        
                    Text("symptoms")
              
    }
}


struct bleeding : View {
    
    var body : some View{
        
        
                    Text("bleeding")
              
    }
}

