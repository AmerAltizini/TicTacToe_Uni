import SwiftUI

struct TypeOfGameOptionView: View {
    
    @StateObject var viewModel = MultiPlayerViewModel()
    @State private var showModalWithComputer = false
    @State private var showModalWithRandomUser = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Button(action: {
                self.showModalWithComputer.toggle()
            }) {
                Text("Play with computer").font(.system(size: 15, weight: .medium, design: .default)).padding() .frame(minWidth: 200, maxWidth: .infinity,alignment: .center)
            }
            .shadow(radius: 5)
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .foregroundColor(Color.white).background(Color.black)
            .cornerRadius(8)
            .fullScreenCover(isPresented: $showModalWithComputer) {
                PlayWithComputer(showModalWithComputer: self.$showModalWithComputer)
            }
            
            Button(action: {
                self.showModalWithRandomUser.toggle()
            }) {
                Text("Play with random user").font(.system(size: 15, weight: .medium, design: .default)).padding()
                    .frame(minWidth: 200, maxWidth: .infinity, alignment: .center)
            }
            .shadow(radius: 5)
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .foregroundColor(Color.white).background(Color.black)
            .cornerRadius(8)
            .fullScreenCover(isPresented: $showModalWithRandomUser) {
                PlayWithRandomUser(viewModel: MultiPlayerViewModel(),  showModalWithRandomUser: self.$showModalWithRandomUser)
            }
            
        }.navigationTitle("Choose game type")
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding()
        
    }
}



struct TypeOfGameOptionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeOfGameOptionView()
    }
}
