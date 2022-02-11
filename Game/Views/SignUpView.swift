import SwiftUI

struct SignUpView : View {
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    
    @EnvironmentObject var viewModel : AppViewModel
    
    var body : some View {
        VStack {
            VStack{
                Image(systemName: "greetingcard").resizable().frame(width: 60, height: 60)
                Text("UNI GAME").font(.system(size: 35, weight: .heavy, design: .default))
                
                TextField("First Name", text: $firstName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                
                TextField("Last Name", text: $lastName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.top)
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.top)
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                Button(action: {
                    guard  !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signUp(email: email, password: password, firstName: firstName, lastName: lastName)
                    
                }) {
                    Text(viewModel.signInLoading ? "Loading...":"Create Account" ).foregroundColor(Color.white).frame(width: 200, height: 50).background(Color.black)
                }
                .alert(isPresented: $viewModel.showAlert, content: { () -> Alert in
                    Alert(title: Text("Sign Up Error"), message: Text(viewModel.authError), dismissButton: .default(Text("Okay")))
                }).cornerRadius(8).padding()
                
                
            }.padding()
            Spacer()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
