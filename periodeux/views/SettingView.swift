
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
                Text("1 Day").tag(1)
                Text("2 Days").tag(2)
                Text("3 Days").tag(3)
                Text("4 Days").tag(4)
                Text("5 Days").tag(5)
                Text("6 Days").tag(6)
                Text("7 Days").tag(7)
                Text("8 Days").tag(8)
                Text("9 Days").tag(9)
                Text("10 Days").tag(10)
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
                Text("21 Days").tag(21)
                Text("22 Days").tag(22)
                Text("23 Days").tag(23)
                Text("24 Days").tag(24)
                Text("25 Days").tag(25)
                Text("26 Days").tag(26)
                Text("27 Days").tag(27)
                Text("28 Days").tag(28)
                Text("29 Days").tag(29)
                Text("30 Days").tag(30)
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



