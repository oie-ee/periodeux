

import SwiftUI

struct InfoInputView: View {
    @State var moods: [MoodModel] = dummyMoodData
    @State var symptoms: [SymptomModel] = dummySymptomData
    @State var bleedings: [BleedingModel] = dummyBleedingData
    @State var showingModalView = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            //Mood and Edit
            HStack(alignment: .bottom){
                
                Text("Mood")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //MoodModel
            AddIconView()
            
            Spacer()
                .frame(height: 15)
            
            //Symptoms and Edit
            
            HStack(alignment: .bottom){
                
                Text("Symptom")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //SymptomsIcons
            AddIconView()
            
            Spacer()
                .frame(height: 15)
            
            //Bleeding and Edit
            HStack(alignment: .bottom){
                
                Text("Bleeding")
                    .font(.headline)
                    .padding(.top, 12)
                
                Button(action: {
                    self.showingModalView.toggle()
                }) {
                    Text("Edit")
                        .font(.caption2)
                        .foregroundColor(ColorManager.highlightOrange)
                        .offset(y: -1)
                }.sheet(isPresented: $showingModalView) {
                    ModalInfoView()
                }
                
                Spacer()
                
            }.frame(width: 325)
            
            //BleedingIcons
            AddIconView()
        }
    }
}

struct InfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        InfoInputView()
    }
}

struct AddIconView: View {
    
    var body: some View {
        
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
        
    }
}
