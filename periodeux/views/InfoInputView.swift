

import SwiftUI

struct InfoInputView: View {
    
    @EnvironmentObject var appStore : AppStore
    
    @State var moods: [MoodModel] = dummyMoodData
    @State var symptoms: [SymptomModel] = dummySymptomData
    @State var bleedings: [BleedingModel] = dummyBleedingData
    @State var showingModalView = false
    
    @State var selectedDiaryTag = 0
    
    @State var exampleFilledDay = "02.01.2021 01:00"
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            // Section Headline
            Text("Entries for \(convertDateToShort(date: appStore.selectedDate))")
                .font(Font.title3.weight(.semibold))
                .padding(.bottom, 2)
            
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
            
            //MoodAddIconCell
            if appStore.selectedDate == generateDateFromString(string: exampleFilledDay){
                
                HStack{
                    
                    SmallMoodCellView(mood: MoodModel.mood6)
                    SmallMoodCellView(mood: MoodModel.mood5)
                    SmallMoodCellView(mood: MoodModel.mood13)
                    
                }
            }else {
                AddIconCellView(selectedDiaryTag: 0, parentState: $selectedDiaryTag)
            }
            
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
            
            //SymptomsAddIconCell
            if appStore.selectedDate == generateDateFromString(string: exampleFilledDay){
                
                HStack{
                    
                    SmallSymptomCellView(symptom: SymptomModel.symptom3)
                    SmallSymptomCellView(symptom: SymptomModel.symptom10)
                    SmallSymptomCellView(symptom: SymptomModel.symptom5)
                    SmallSymptomCellView(symptom: SymptomModel.symptom8)
                }
            } else {
                AddIconCellView(selectedDiaryTag: 1, parentState: $selectedDiaryTag)
            }
            
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
            
            //BleedingAddIconCell
            if appStore.selectedDate == generateDateFromString(string: exampleFilledDay){
                
                HStack{
                    
                    SmallBleedingCellView(bleeding: BleedingModel.bleeding1)
                }
            } else {
                AddIconCellView(selectedDiaryTag: 2, parentState: $selectedDiaryTag)
            }
        }
    }
    
    /// This shortens a date to the string format, e.g. 01 January 2021
    /// - Parameter date: Type Date is accepted
    /// - Returns: A stringof the shortened date, e.g. 01 January 2021
    func convertDateToShort(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM y"
        
        return formatter.string(from: date)
    }
    
    //Generate Date From String
    func generateDateFromString(string: String) -> Date{
        
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "DD.MM.y HH:mm"
        
        return (stringFormatter.date(from: string) ?? Date())
    }
}

struct InfoInputView_Previews: PreviewProvider {
    
    @State var selectedDiaryTag: Int
    
    static var previews: some View {
        InfoInputView(selectedDiaryTag: 0)
    }
}

struct AddIconCellView: View {
    
    @State var showingModalView = false
    @State var selectedDiaryTag: Int
    @Binding var parentState: Int
    
    var body: some View {
        
        Button(action: {
            self.showingModalView.toggle()
            parentState = selectedDiaryTag
            
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
            ModalInfoView(selectedDiaryTag: $parentState)
        }
    }
}
