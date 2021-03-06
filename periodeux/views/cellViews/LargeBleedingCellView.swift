

// MARK: - LargeBleedingCellView
//this is a larger Icon and Title display for the detailed ModalInfoView


import SwiftUI

struct LargeBleedingCellView: View {
    
    var bleeding: BleedingModel
    @State var isSelected = false
    
    // MARK: - Body
    var body: some View {
        
        Button(action: {
            print("\(bleeding.name) was selected")
            isSelected.toggle()
        }, label: {
            
            VStack {
                
                if(isSelected){
                    Image("\(bleeding.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(ColorManager.highlightOrange, lineWidth: 3)
                        )
                }else {
                    Image("\(bleeding.imageIcon):68x68")
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.clear, lineWidth: 3)
                        )
                }
                
                Text(bleeding.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .frame(width: 80, height: 48, alignment: .top)
                    .multilineTextAlignment(.center)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            }
        })
    }
}

// MARK: - Preview
struct LargeBleedingCellView_Previews: PreviewProvider {
    static var previews: some View {
        LargeBleedingCellView(bleeding: BleedingModel.bleeding1)
    }
}
