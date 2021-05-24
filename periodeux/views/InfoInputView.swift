

import SwiftUI

struct InfoInputView: View {
    
    // MARK: - Properties
    
    
    @State var moods: [MoodModel] = moodModel
    @State var symptoms: [SymptomModel] = symptomModel
    @State var bleedings: [BleedingModel] = bleedingModel
    @State var showingModalView = false
    
    @State var selectedDiaryTag = 0
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var currentReport: ReportDB = ReportDB()
    
    // MARK: - Body
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
            
            AddIconCellView(selectedDiaryTag: 0, parentState: $selectedDiaryTag)
            
            HStack {
                ForEach(appStore.currentReport.moodList, id: \.self) {
                    let iconName = String($0.lowercased().filter { !" \n\t\r".contains($0) })
                    
                    let model = MoodModel(name: $0, imageIcon: "mood:\(iconName)")
                    
                    SmallMoodCellView(mood: model)
                }
            }
            
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
            
            
            AddIconCellView(selectedDiaryTag: 1, parentState: $selectedDiaryTag)
            
            HStack {
                ForEach(appStore.currentReport.symptomList, id: \.self) {
                    let iconName = String($0.lowercased().filter { !" \n\t\r".contains($0) })
                    
                    let model = SymptomModel(name: $0, imageIcon: "symptom:\(iconName)")
                    
                    SmallSymptomCellView(symptom: model)
                }
            }
            
        
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
            
            
            
            HStack {
                let bleeding = appStore.currentReport.bleeding
                
                if(bleeding != Int.min){
                    let model = bleedingModel[bleeding]
                    SmallBleedingCellView(bleeding: model)
                }
                else {
                    AddIconCellView(selectedDiaryTag: 2, parentState: $selectedDiaryTag)
                }
                
            }
            
        }.onAppear {
            let reportID = reportStore.getExistingReportID(date: appStore.selectedDate)
            if(reportID != 0) {
                let report = reportStore.findByID(id: reportID)
                appStore.currentReport = report!
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
        stringFormatter.dateFormat = "dd MMMM y HH:mm"
        
        return (stringFormatter.date(from: string) ?? Date())
    }
}



// MARK: - Add Icon Cells
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
                    //the following are added so that the Add Icon Cell takes up th esame space as a Small Icon View
                    .frame(width: 50, height: 30, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
            
        }.sheet(isPresented: $showingModalView) {
            ModalInfoView(selectedDiaryTag: $parentState)
        }
    }
}
