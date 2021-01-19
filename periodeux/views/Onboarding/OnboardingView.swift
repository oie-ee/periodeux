

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    
    var board: [Board] = boardData
    
    // MARK: - Body
    var body: some View {
        TabView {
            ForEach(board[0...2])
            { item in
                OnboardingCardView(board: item)
            }
        } //: Tab
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(board: boardData)
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11 Pro")
    }
}
