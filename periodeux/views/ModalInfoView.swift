
import SwiftUI

struct ModalInfoView: View {
    //@State var showingModalView = false
    @State var selectedDiaryTag: Int = 0
    @State var selectedDiary: String = "mood"
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Picker("Diary Picker", selection: $selectedDiaryTag) {
                        Text("mood").tag(0)
                        Text("symptom").tag(1)
                        Text("bleeding").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
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
                Spacer()
                    if selectedDiaryTag == 0{
                        Mood()
                    }
    
                    if selectedDiaryTag == 1 {
                        Symptom()
                    }
    
                    if selectedDiaryTag == 2 {
                        Bleeding()
                    }
                
            }
            .navigationBarTitle(Text("16.12.2020"))
            .navigationBarItems(trailing:
                    Button(action: {
                        //showingModalView.toggle()
                        self.mode.wrappedValue.dismiss()
                    }, label: {
                        Text("done")
                            .foregroundColor(Color(UIColor(named: "highlightOrange")!))
                    })
            )
        }
        
    }
}

struct ModalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalInfoView()
    }
}







struct Mood : View {
    
    @State var moods: [MoodModel] = dummyMoodData
    
    var body : some View{
        
        HStack(spacing: 20) {
            ForEach(moods){
                mood in
                LargeMoodCellView(mood: mood)
            }
        }
        
    }
}


struct Symptom : View {
    
    var body : some View{
        
        
        Text("symptoms")
        
    }
}


struct Bleeding : View {
    
    var body : some View{
        
        
        Text("bleeding")
        
    }
}

