import SwiftUI

struct LargeMoodCellView: View {
    
    var mood: MoodModel
    @State var isSelected = false
    
    var body: some View {
        
        Button(action: {
            print("\(mood.name) was selected")
            isSelected.toggle()
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image(systemName: mood.imageIcon)
                        .resizable()
                        .frame(width: 68, height: 68)
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(ColorManager.highlightOrange, lineWidth: 4)
                        )
                }else {
                    Image(systemName: mood.imageIcon)
                        .resizable()
                        .frame(width: 68, height: 68)
                        .foregroundColor(.gray)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.clear, lineWidth: 4)
                        )
                }
                
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


//VStack{
//    Button(action: {
//        print("\(mood.name) was selected")
//        isSelected.toggle()
//    }, label: {
//        VStack{
//
//            if(isSelected) {
//                Image(systemName: mood.imageIcon)
//                    .resizable()
//                    .frame(width: 44, height: 44)
//                    .foregroundColor(.gray)
//                // Border Klimmbimm
//            } else {
//                Image(systemName: mood.imageIcon)
//                    .resizable()
//                    .frame(width: 44, height: 44)
//                    .foregroundColor(.gray)
//                // Border Klimmbimm
//            }
//
//
//            Text(mood.name)
//                .font(.caption2)
//                .foregroundColor(.black)
//        }
//    })
//}
//}
//}
