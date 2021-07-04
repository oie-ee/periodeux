
import SwiftUI

struct SettingView: View {
    
    // MARK: - Properties
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @EnvironmentObject var appStore : AppStore
    @Environment(\.presentationMode) var presentationMode
    @State var showComposeMessageView: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                
                List {
                    
                    HStack {
                        Image(systemName: "drop.fill")
                            .foregroundColor(ColorManager.highlightOrange)
                            .frame(width: 24)
                        PeriodDuration()
                    }
                    
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundColor(ColorManager.highlightOrange)
                            .frame(width: 24)
                        CycleDuration()
                    }
                    VStack {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(ColorManager.highlightOrange)
                                .frame(width: 24)
                            FirstPeriod()
                        }
                        
                        Text("Please enter the first day of your last period here.")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    
                    
                    HStack {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .foregroundColor(ColorManager.backgroundOrange)
                            .frame(width: 24)
                        
                        Toggle(isOn: $isOnboarding) {
                            if isOnboarding {
                                Text("Restarted Onboarding")
                                    .fontWeight(.bold)
                            } else {
                                Text("Restart Onboarding")
                            }
                        }.toggleStyle(SwitchToggleStyle(tint: ColorManager.highlightOrange))
                    }
                }
            }.navigationTitle("Settings")
            .listStyle(InsetGroupedListStyle())
        }
    }
}


// MARK: - Period Duration
struct PeriodDuration: View {
    
    @AppStorage("isPeriodDuration") private var isPeriodDuration = 7
    
    var body: some View {
        VStack{
            Picker("Period Duration", selection: $isPeriodDuration) {
                Text("1 day").tag(1)
                Text("2 days").tag(2)
                Text("3 days").tag(3)
                Text("4 days").tag(4)
                Text("5 days").tag(5)
                Text("6 days").tag(6)
                Text("7 days").tag(7)
                Text("8 days").tag(8)
                Text("9 days").tag(9)
                Text("10 days").tag(10)
            }
        }
    }
}

// MARK: - Cycle Duration
struct CycleDuration: View {
    @AppStorage("isCycleDuration") private var isCycleDuration = 21
    
    var body: some View {
        VStack{
            Picker("Cycle Duration", selection: $isCycleDuration) {
                Text("21 days").tag(21)
                Text("22 days").tag(22)
                Text("23 days").tag(23)
                Text("24 days").tag(24)
                Text("25 days").tag(25)
                Text("26 days").tag(26)
                Text("27 days").tag(27)
                Text("28 days").tag(28)
                Text("29 days").tag(29)
                Text("30 days").tag(30)
            }
        }
    }
}

// MARK: - First Day Of Last Period
struct FirstPeriod: View {
    @AppStorage("isFirstPeriod") private var isFirstPeriod = Date()
    
    var body: some View {

        DatePicker("Start Of Period", selection: $isFirstPeriod, displayedComponents: [.date])
    
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

// MARK: - Preview
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}



