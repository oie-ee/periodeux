import SwiftUI

struct LargeMoodCellView: View {
    
    var mood: MoodModel
    
    var body: some View {
        
        Button(action: {
            print("\(mood.name) was selected")
        }, label: {
            
            VStack {
                
                Image(systemName: mood.imageIcon)
                    .resizable()
                    .frame(width: 68, height: 68)
                    .foregroundColor(.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(ColorManager.highlightOrange, lineWidth: 4)
                    )
                
                Text(mood.name)
                    .font(.callout)
                    .foregroundColor(.black)
                    .frame(width: 80, height: 48)
                    .multilineTextAlignment(.center)
            }
        })
    }
}

struct LargeMoodCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeMoodCellView(mood: MoodModel.mood11)
    }
}
