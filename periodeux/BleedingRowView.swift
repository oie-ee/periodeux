
import SwiftUI

struct BleedingRowView: View {
    var bleeding: BleedingModel
    
    var body: some View {
       
        HStack {
            
            VStack{
                
                Image(systemName: bleeding.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)
                
                Text(bleeding.name)
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .frame(maxWidth: 46)
            }
        }
    }
}

struct BleedingRowView_Previews: PreviewProvider {
    static var previews: some View {
        BleedingRowView(bleeding: BleedingModel.bleeding1)
    }
}
