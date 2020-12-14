
import SwiftUI

struct BleedingRowView: View {

    @State var showingModalView = false


    var bleeding: BleedingModel

    var body: some View {

        HStack {

            VStack{
            Button(action: {
                print("\(bleeding.name) was selected")
           }, label: {

            VStack{
                Image(systemName: bleeding.imageIcon)
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.gray)

                Text(bleeding.name)
                    .font(.caption2)
                    .foregroundColor(.black)
                              }
                          })
                      }
                  }
                  .sheet(isPresented: $showingModalView) {
                      ModalInfoView()


              }
    }
}
struct BleedingRowView_Previews: PreviewProvider {
    static var previews: some View {
        BleedingRowView(bleeding: BleedingModel.bleeding1)
    }
}




