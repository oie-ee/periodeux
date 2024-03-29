
import SwiftUI

struct RectangleWrapperView: View {
    
    @EnvironmentObject var appStore : AppStore
    @EnvironmentObject var reportStore : ReportStore
    
    // MARK: - Body
    var body: some View {
        
        //RectangleView
        ZStack{
            
            //Rectangle
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(ColorManager.lightestElement)
                .shadow (color: Color.black.opacity(0.1), radius: 60.0, x: 0, y: 10)
            
            //What is in the rectangle
            VStack{
                
                CalendarView()
                //Divider
                Divider()
                    .padding([.leading, .trailing], 12.0)
                    .padding(.bottom, 16)
                
                InfoInputView()
                    .padding([.leading, .trailing], 12.0)
                
                Spacer()
            }.padding([.top, .bottom])
        }
    }
}

// MARK: - Preview
struct RectangleWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleWrapperView()
    }
}
