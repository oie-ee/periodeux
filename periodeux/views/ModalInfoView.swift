
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
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var moods: [MoodModel] = dummyMoodData
    
    
    var body : some View{
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            
            let existingReport = reportStore.getExistingReportID(date: appStore.selectedDate)
            
            // When no Report is currently existing display the default
            // one with every mood set to false
            if(existingReport == 0) {
                ForEach(moods){
                    mood in
                    LargeMoodCellView(mood: mood, isSelected: false)
                }
            }
            
            else {
                let report = reportStore.findByID(id: existingReport)!
                
                ForEach(moods) {
                    mood in
                        let selectedMood = report.moodList.index(of: mood.name) ?? Int.max
                        if(selectedMood != Int.max) {
                            LargeMoodCellView(mood: mood, isSelected: true)
                        } else {
                            LargeMoodCellView(mood: mood, isSelected: false)
                        }
                        
                }
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
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var symptoms: [SymptomModel] = dummySymptomData
    
    var body : some View{
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            
            let existingReport = reportStore.getExistingReportID(date: appStore.selectedDate)
            
            // When no Report is currently existing display the default
            // one with every mood set to false
            if(existingReport == 0) {
                ForEach(symptoms){
                    symptom in
                    LargeSymptomCellView(symptom: symptom, isSelected: false)
                }
            }
            
            else {
                let report = reportStore.findByID(id: existingReport)!
                
                ForEach(symptoms) {
                    symptom in
                        let selectedSymptom = report.symptomList.index(of: symptom.name) ?? Int.max
                        if(selectedSymptom != Int.max) {
                            LargeSymptomCellView(symptom: symptom, isSelected: true)
                        } else {
                            LargeSymptomCellView(symptom: symptom, isSelected: false)
                        }
                        
                }
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
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var isActive : [Bool] = [false, false, false, false]
    
    var body : some View {
        
        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(Array(bleedings.enumerated()), id: \.offset) { index, bleeding in
                
                LargeBleedingCellView(bleeding: bleeding, isActive: $isActive, index: index)
                
            }

        }
        .padding([.leading, .trailing])
        .onAppear {
            let reportID = reportStore.getExistingReportID(date: appStore.selectedDate)
            if(reportID != 0) {
                let report = reportStore.findByID(id: reportID)!
                
                self.isActive = self.generateIsActiveArrayFromReport(report: report)
            }
        }
        
        Spacer()
    }
    
    func generateIsActiveArrayFromReport (report: ReportDB) -> [Bool] {
        var isActive : [Bool] = [false, false, false, false]
        
        isActive[report.bleeding] = true
        
        return isActive
    }
}
