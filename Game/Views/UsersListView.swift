import SwiftUI


struct UsersListView: View {
    init(){
        viewModel.fetchUsers()
    }
    @ObservedObject var viewModel = UserViewModel()
    @State var list = [String]()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Users List").font(.system(size: 35, weight: .heavy, design: .default))
            List(viewModel.users) { user in
                HStack{
                    Text("\(user.firstName) \(user.lastName)").font(.system(size: 15, weight: .medium, design: .default)).padding().frame(minWidth: 200, maxWidth: .infinity,alignment: .leading)
                    Button(action: {
                        if !list.contains(user.id) {
                            list.append(user.id)
                            viewModel.updateFriends(friendId: user.id)
                        }else{
                            list = list.filter{$0 != user.id}
                            viewModel.removeFriends(friendId: user.id)
                        }
                    }) {
                        Image(systemName: list.contains(user.id) ? "minus.circle" : "plus.circle").resizable().resizable().frame(width: 20, height: 20,alignment: .trailing).padding()
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
        .onAppear{
            viewModel.fetchUsers()
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
