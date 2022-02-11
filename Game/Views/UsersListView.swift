import SwiftUI


struct UsersListView: View {
    @ObservedObject var viewModel = UserViewModel()
    //    guard let userID = Auth.auth().currentUser?.uid else { return }
    var body: some View {
        VStack(alignment: .leading) {
            Text("Users List").font(.system(size: 35, weight: .heavy, design: .default))
            List(viewModel.users) { user in
                
                HStack{
                    Text("\(user.firstName) \(user.lastName)").font(.system(size: 15, weight: .medium, design: .default)).padding().frame(minWidth: 200, maxWidth: .infinity,alignment: .leading)
                    Button(action: {
                        viewModel.updateFriends(friendId: user.id)
//                        let friendsList = viewModel.currentUserInformation?.friends
//                        var duplicateArray = [String]()
//                        if friendsList == nil {
//                            duplicateArray = []
//                        } else {
//                            duplicateArray = friendsList
//                            duplicateArray = duplicateArray.append(user.id)
//                        }
//                         var updatedFriendsList = duplicateArray.append(user.id)?
//                        viewModel.updateUser(id: viewModel.currentUserInformation?.id, firstName: viewModel.currentUserInformation?.firstName, lastName: viewModel.currentUserInformation?.lastName , friends: user.id)
                        
                    }) {
                        Image(systemName: "plus.circle").resizable().resizable().frame(width: 20, height: 20,alignment: .trailing).padding()
                    }.buttonStyle(BorderlessButtonStyle())
                    
                }
                .listRowInsets(EdgeInsets())
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, minHeight: 50,alignment: .leading)
                .foregroundColor(Color.white).background(Color.black)
                .cornerRadius(8)
                .padding(.vertical)
            }.listStyle(PlainListStyle())
                .onTapGesture {return}
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .background(.white)
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
