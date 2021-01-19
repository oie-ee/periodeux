
import SwiftUI
import Foundation

struct ModalInfoView: View {
    
    @EnvironmentObject var appStore : AppStore
    
    @State var date = Date()
    
    @State var diaryTags = ["Mood", "Symptom", "Bleeding"]
    @Binding var selectedDiaryTag: Int
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                VStack {
                    
                    Picker("Diary Picker", selection: $selectedDiaryTag) {
                        ForEach(0..<diaryTags.count) { index in
                            Text(self.diaryTags[index]).tag(index)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedDiaryTag, perform: {
                        changedValue in
                        
                        if changedValue == 0 {
                            selectedDiaryTag = 0
                        }
                        
                        if changedValue == 1 {
                            selectedDiaryTag = 1
                        }
                        
                        if changedValue == 2 {
                            selectedDiaryTag = 2
                        }
                        
                    })
                }
                
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
            .navigationBarTitle(Text("\(convertDateToShort(date: appStore.selectedDate))"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.mode.wrappedValue.dismiss()
                                    }, label: {
                                        Text("Done")
                                            .foregroundColor(ColorManager.highlightOrange)
                                    })
            )
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
}

// MARK: - Preview
struct ModalInfoView_Previews: PreviewProvider {
    
    @Binding var selectedDiaryTag: Int
    
    static var previews: some View {
        ModalInfoView(selectedDiaryTag: .constant(2))//constant disables picker
    }
}

// MARK: - Mood Grid
struct Mood : View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var moods: [MoodModel] = dummyMoodData
    
    var body : some View{
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            
            ForEach(moods){
                mood in
                LargeMoodCellView(mood: mood)
            }
        }.padding([.leading, .trailing])
        
        Spacer()
    }
}

// MARK: - Symptom Grid
struct Symptom : View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var symptoms: [SymptomModel] = dummySymptomData
    
    var body : some View{
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            
            ForEach(symptoms){
                symptom in
                LargeSymptomCellView(symptom: symptom)
            }
        }.padding([.leading, .trailing])
        
        Spacer()
    }
}

// MARK: - Bleeding Grid
struct Bleeding : View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var bleedings: [BleedingModel] = dummyBleedingData
    
    var body : some View{
        
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            
            ForEach(bleedings){
                bleeding in
                LargeBleedingCellView(bleeding: bleeding)
            }
        }.padding([.leading, .trailing])
        
        Spacer()
    }
}
