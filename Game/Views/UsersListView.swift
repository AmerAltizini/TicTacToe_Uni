import SwiftUI

struct UsersListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Users List").font(.system(size: 35, weight: .heavy, design: .default))
            
            
            HStack{
                Text("Play with computer").font(.system(size: 15, weight: .medium, design: .default)).padding() .frame(minWidth: 200, maxWidth: .infinity,alignment: .leading)
                Button(action: {
//                    self.showModalWithComputer.toggle()
                }) {
                    Image(systemName: "plus.circle").resizable().resizable().frame(width: 20, height: 20,alignment: .trailing).padding()
                }
               
            }
            .shadow(radius: 5)
            .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
            .foregroundColor(Color.white).background(Color.black)
            .cornerRadius(8)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
