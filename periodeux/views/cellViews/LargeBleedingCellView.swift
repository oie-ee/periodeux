
import SwiftUI

struct LargeBleedingCellView: View {
    
    var bleeding: BleedingModel
    
    var body: some View {
        
        Button(action: {
            print("\(bleeding.name) was selected")
        }, label: {
            
            VStack {
                
                Image(systemName: bleeding.imageIcon)
                    .resizable()
                    .frame(width: 68, height: 68)
                    .foregroundColor(.gray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(ColorManager.highlightOrange, lineWidth: 4)
                    )
                
                Text(bleeding.name)
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(width: 80, height: 48)
                    .multilineTextAlignment(.center)
            }
        })
    }
}

struct LargeBleedingCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeBleedingCellView(bleeding: BleedingModel.bleeding1)
    }
}
