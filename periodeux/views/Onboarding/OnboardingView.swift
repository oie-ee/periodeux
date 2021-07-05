

import SwiftUI



struct OnboardingView: View {
    // MARK: - Properties
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @EnvironmentObject var appStore : AppStore
    @Environment(\.presentationMode) var presentationMode
    @State var showComposeMessageView: Bool = false
    
    var board: [Board] = boardData
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            VStack {
                NavigationView {
                           VStack {
                
                        
                        Image("placeholder1")
                        .resizable()
                        .cornerRadius(20)
                        .scaledToFit()

                        .padding(.top, 30)
                        
                        Text("Customize your data")
                                //.foregroundColor(Color.white)
                                .font(.title)
                            .fontWeight(.bold)
                                //.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                            
                        Spacer()
                            
                        Text("Please enter your period information.\nIt can be adjusted anytime.")
                               // .foregroundColor(Color.white)
                               // .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: 480)
                                      

                        Form {
                            HStack {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(ColorManager.highlightOrange)
                                    .frame(width: 12)
                                PeriodDuration()
                            }
                            HStack {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .foregroundColor(ColorManager.highlightOrange)
                                    .frame(width: 12)
                                CycleDuration()
                            }
                            VStack {
                                HStack {
                                    Image(systemName: "sparkles")
                                        .foregroundColor(ColorManager.highlightOrange)
                                        .frame(width: 12)
                                    FirstPeriod()
                                }
                                
                                Text("Please enter the first day of your last period here.")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13))
                            }
                                }
                                .onAppear {
                                UITableView.appearance().backgroundColor = .secondarySystemBackground
                                }
                            
                        }
                        
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                           .background(Color(.secondarySystemBackground))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        .padding(.top, 30)
                        .listStyle(GroupedListStyle())
                        .accentColor(ColorManager.highlightOrange)
//                        .background(ColorManager.backgroundOrange.edgesIgnoringSafeArea(.all))
                    }
            }
        }

        StartButtonView()

    }
}



// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView(board: boardData)

                .previewDevice("iPhone 11 Pro")
            OnboardingView(board: boardData)
                .previewDevice("iPhone 11 Pro")
        }
    }
}

