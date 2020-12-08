
import SwiftUI

struct ModalInfoView: View {
    var body: some View {
        VStack {
            
            Picker("InfoPicker", selection: .constant(0)){
                Text("Mood").tag(0)
                Text("Symptoms").tag(1)
                Text("Bleeding").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Spacer()
        }
    }
}

struct ModalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ModalInfoView()
    }
}
