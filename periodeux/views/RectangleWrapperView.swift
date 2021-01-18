
import SwiftUI

struct RectangleWrapperView: View {
    
    var body: some View {
        
        //RectangleView
        ZStack{
            
            //Rectangle
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow (color: Color.black.opacity(0.1), radius: 60.0, x: 0, y: 10)
            
            //What is in the rectangle
            VStack{
                
                CalendarView()
                
                //Divider
                Divider()
                    .padding([.leading, .trailing], 12.0)
                    .padding(.bottom, 12)
                
                InfoInputView()
                    .padding([.leading, .trailing], 12.0)
                
                Spacer()
            }.padding([.top, .bottom])
        }
       // .frame(width: 360)
        
    }
}

struct RectangleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleWrapperView()
    }
}
