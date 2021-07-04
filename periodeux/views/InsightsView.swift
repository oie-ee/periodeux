
// MARK: - Insights

import SwiftUI

struct InsightsView: View {
    
    @AppStorage("isCycleDuration") private var isCycleDuration = 21
    @AppStorage("isPeriodDuration") private var isPeriodDuration = 7
    
    @State var showComposeMessageView: Bool = false
    
    @EnvironmentObject var reportStore : ReportStore
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack (alignment: .leading){
                    
                    // MARK: - First Section
                    Text("Your Average Cycle Length")
                        .font(Font.title3.weight(.semibold))
                        
                    
                    ZStack {
                        
                        Image("averagelength:cycle")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        HStack{
                            Text("\(isCycleDuration)").font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
                                .foregroundColor(ColorManager.highlightOrange)
                                .frame(height: 120)
                            
                            Text("days").font(.system(.subheadline, design: .rounded)).fontWeight(.bold)
                                .foregroundColor(ColorManager.highlightOrange)
                                .offset(x: -6, y: 6.5)
                        }
                        
                    }.padding(.bottom, 16)
                    
                    Text("Your Average Period Length")
                        .font(Font.title3.weight(.semibold))
                    
                    ZStack {
                        
                        Image("averagelength:period")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        
                        HStack{
                            Text("\(isPeriodDuration)").font(.system(.largeTitle, design: .rounded)).fontWeight(.bold)
                                .foregroundColor(ColorManager.highlightOrange)
                                .frame(height: 120)
                            
                            Text("days").font(.system(.subheadline, design: .rounded)).fontWeight(.bold)
                                .foregroundColor(ColorManager.highlightOrange)
                                .offset(x: -6, y: 6.5)
                        }
                        
                    }.padding(.bottom, 16)
                    
                   
                        
                    
                    // MARK: - Second Section
                    Group{
                        Text("Mood Prognosis")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("This is how you are most likely going to feel in the days leading up to your period:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                LargeMoodCellView(mood: MoodModel.mood5, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood7, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood1, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood2, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood11, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood8, isSelected: false)
                                    .disabled(true)
                            }.padding(.bottom, 32)
                            
                        }
                    }
                    
                    // MARK: - Third Section
                    Group{
                        Text("Frequent Symptoms")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("These are your most frequently reported symptoms:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                ForEach(self.calculateFrequentSymptoms(), id: \.0) { symptom, count in
                                    
                                    let iconName = String(symptom.lowercased().filter { _ in !" \n\t\r".contains(symptom) })
                                    
                                    let model = SymptomModel(name: symptom, imageIcon: "symptom:\(iconName)")
                                    
                                    VStack {
                                        LargeSymptomCellView(symptom: model, isSelected: false)
                                        Text("\(count)")
                                    }
                                }
                            
                            }.padding(.bottom, 32)
                        }
                    }
                    
                    // MARK: - Fourth Section
                    Group{
                        Text("Frequent Moods")
                            .font(Font.title3.weight(.semibold))
                            .padding(.bottom, 2)
                        
                        Text("These are your most frequently reported moods:")
                            .font(Font.body.weight(.regular))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 15)
                        
                        ScrollView(.horizontal) {
                            
                            HStack(spacing: 5){
                                LargeMoodCellView(mood: MoodModel.mood1, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood13, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood6, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood4, isSelected: false)
                                    .disabled(true)
                                LargeMoodCellView(mood: MoodModel.mood10, isSelected: false)
                                    .disabled(true)
                            }
                        }
                    }
                    
                    Spacer()
                    
                }.navigationTitle("Insights")
                .padding([.top, .leading, .trailing])
                
            }
        }
    }
    
    func calculateFrequentSymptoms () -> [(String, Int)] {
        var allSymptomsFromDatabase = [String]()
        
        // Get all reports from database and store every symptom in one array
        reportStore.reports.forEach { (report) in
            report.symptomList.forEach { (symptom) in
                allSymptomsFromDatabase.append(symptom)
            }
        }
        
        // Use the array with Symptoms and count them,
        // sort them descending and put them in a dictionary
        let sortedSymptoms = allSymptomsFromDatabase
            .reduce(into: [:]) { counts, word in counts[word, default: 0] += 1 }
            .sortedByValueDecending

//        print("Sorted Symptom Dictionary: \(counts)")
        
        return sortedSymptoms
    }
}


extension Dictionary where Value: Comparable {
    var sortedByValueAscending: [(Key, Value)] { return Array(self).sorted { $0.1 < $1.1} }
    
    var sortedByValueDecending: [(Key, Value)] { return Array(self).sorted { $0.1 > $1.1} }
}


extension Dictionary where Key: Comparable {
    var sortedByKey: [(Key, Value)] { return Array(self).sorted { $0.0 < $1.0 } }
}


// MARK: - Preview
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView()
    }
}



