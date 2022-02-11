import SwiftUI

struct AccountView: View {
    @EnvironmentObject var viewModel : AppViewModel
    @ObservedObject var userViewModel = UserViewModel()
    
    init() {
        userViewModel.fetchCurrentUser()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack{
                Spacer()
                Image(systemName: "person.circle.fill").resizable().frame(width: 120, height: 120, alignment: .center)
                Spacer()
            }
            if(userViewModel.currentUserInformation != nil){
                Text("\(userViewModel.currentUserInformation!.firstName) \(userViewModel.currentUserInformation!.lastName)").font(.system(size: 35, weight: .heavy, design: .default))
            }else{
                Text("").font(.system(size: 35, weight: .heavy, design: .default))
            }
            
            NavigationLink(destination: FriendsList()){
                HStack {
                    Image(systemName: "person.2").resizable().frame(width: 40, height: 20, alignment: .center)
                    Text("Friends").font(.system(size: 25, weight: .medium , design: .default))
                }.frame(width: 200, height: 50).foregroundColor(.blue)
            }
            
            Link(destination: URL(string: "https://wa.me/15551234567?text=Please%20join%20me%20play%20tik%20tak%20toe")!, label : {
                Text("Share to others ").font(.system(size: 25, weight: .medium , design: .default)).foregroundColor(.blue)
            })
            Spacer()
            Button(action: {
                viewModel.signOut()
            }) {
                Text("Sign Out" ).foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black).cornerRadius(9)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
