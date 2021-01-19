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
        }
    }
}


struct BleedingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SmallBleedingCellView(bleeding: BleedingModel.bleeding1)
    }
}
