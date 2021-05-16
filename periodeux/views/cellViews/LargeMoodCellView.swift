
// MARK: - LargeMoodCellView
//this is a larger Icon and Title display for the detailed ModalInfoView

import SwiftUI

enum Action  {
    case add
    case remove
    
    var bool: Bool {
        switch self {
        case .add:
            return true
        default:
            return false
        }
    }
}

struct LargeMoodCellView: View {
    
    var mood: MoodModel
    @State var isSelected = false
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    @State var moods: [MoodModel] = dummyMoodData
    
    // MARK: - Body
    var body: some View {
        
        Button(action: {
            print("\(mood.name) was selected")
            
            // HOOK Save Report
            var action : Action
            
            if(isSelected) {
                action = Action.remove
            } else {
                action = Action.add
            }
            
            isSelected.toggle()
            
            reportStore.create(date: appStore.selectedDate, moodType: mood.name, moodAction: action)
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image("\(mood.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(ColorManager.highlightOrange, lineWidth: 3)
                        )
                }else {
                    Image("\(mood.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.clear, lineWidth: 3)
                        )
                }
                
                Text(mood.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .frame(width: 80, height: 48, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        })
    }
}

// MARK: - Preview
struct LargeMoodCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeMoodCellView(mood: MoodModel.mood1)
    }
}
