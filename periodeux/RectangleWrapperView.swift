
import SwiftUI

struct RectangleWrapperView: View {
    var body: some View {
        
        //RectangleView
        ZStack{
            
            //Rectangle
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .frame(minWidth: 342, maxWidth: 350)
                .shadow (color: Color.black.opacity(0.1), radius: 60.0, x: 0, y: 10)
            
            //What is in the rectangle
            VStack{
                CalendarView()
                
                //Divider
                Divider()
                    .padding(.top, 200)
                    .frame(width: 325)
                
                Spacer()
            }
        }
        
    }
}

struct RectangleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleWrapperView()
    }
}
