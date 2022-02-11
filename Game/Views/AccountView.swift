import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel : AppViewModel
    
    var body: some View {
        VStack {
            Text("You are signed in")
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out").foregroundColor(Color.blue)})
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
