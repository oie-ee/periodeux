
import SwiftUI

struct OnboardingHeaderView: View {
    // MARK: - Properties

    var board: Board
    
    @State private var isAnimatingImage: Bool = false

    // MARK: - Body
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: board.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
            Image(board.image)
                .resizable()
                .scaledToFit()
                .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 0.15, x: 6, y: 8)
                .padding(.vertical, 20)
                .scaleEffect(isAnimatingImage ? 1.0 : 0.6)
        } //: End of Zstack
        .frame(height: 440)
        .onAppear() {
            withAnimation(.easeOut(duration: 0.5)) {
                isAnimatingImage = true
            }
        }
    }
}

// MARK: - Preview
struct OnboardingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHeaderView(board: boardData[0])
            .previewLayout(.fixed(width: 375, height: 440))
    }
}
