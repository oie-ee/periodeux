
// MARK: - SmallBleedingCellView
//this is a small Icon and Title display for the InfoInputView

import SwiftUI

struct SmallBleedingCellView: View {
    
    var bleeding: BleedingModel
    
    var body: some View {
        
        VStack{
            
            Image("\(bleeding.imageIcon):44x44")
            
            Text(bleeding.name)
                .font(.caption2)
                .foregroundColor(.black)
                .frame(width: 50, height: 30, alignment: .top)
                .multilineTextAlignment(.center)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
        }
    }
}

// MARK: - Preview
struct BleedingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallBleedingCellView(bleeding: BleedingModel.bleeding1)
    }
}
