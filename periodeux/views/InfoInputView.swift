

import SwiftUI

struct InfoInputView: View {
    @State var moods: [MoodModel] = dummyMoodData
    @State var symptoms: [SymptomModel] = dummySymptomData
    @State var bleedings: [BleedingModel] = dummyBleedingData
    @State var showingModalView = false
    
    @State var selectedDiaryTag = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            //Mood and Edit
            HStack(alignment: .bottom){
                
                Text("Mood")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                    selectedDiaryTag = 0
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView(selectedDiaryTag: $selectedDiaryTag)
                }
                
                Spacer()
                
            }
            
            //MoodModel
            AddIconView(selectedDiaryTag: 0)
            
            Spacer()
                .frame(height: 15)
            
            //Symptoms and Edit
            
            HStack(alignment: .bottom){
                
                Text("Symptom")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                    selectedDiaryTag = 1
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView(selectedDiaryTag: $selectedDiaryTag)
                }
                
                Spacer()
                
            }
            
            //SymptomsIcons
            AddIconView(selectedDiaryTag: 1)
            
            Spacer()
                .frame(height: 15)
            
            //Bleeding and Edit
            HStack(alignment: .bottom){
                
                Text("Bleeding")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                    selectedDiaryTag = 2
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView(selectedDiaryTag: $selectedDiaryTag)
                }
                
                Spacer()
                
            }
            
            //BleedingIcons
            AddIconView(selectedDiaryTag: 2)
        }
    }
}

struct InfoInputView_Previews: PreviewProvider {

    @State var selectedDiaryTag: Int

    static var previews: some View {
        InfoInputView(selectedDiaryTag: 0)
    }
}

struct AddIconView: View {
    
    @State var showingModalView = false
    @State var selectedDiaryTag: Int
    
    var body: some View {
        
        Button(action: {
            self.showingModalView.toggle()
        }) {
            VStack{
                
                ZStack {
                    
                    Image(systemName: "app.fill")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .foregroundColor(ColorManager.backgroundOrange)
                    
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(ColorManager.highlightOrange)
                }
                
                Text("Add")
                    .font(.caption2)
                    .foregroundColor(.black)
            }
            
        }.sheet(isPresented: $showingModalView) {
            ModalInfoView(selectedDiaryTag: $selectedDiaryTag)//change this part so that changed segmented cotrol always jumps back when reopened
        }
    }
}
