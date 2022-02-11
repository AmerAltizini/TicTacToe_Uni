import Foundation
import FirebaseAuth
import Firebase

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var signInLoading = false
    @Published var showAlert = false
    @Published var authError = ""
    
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    
    func signIn(email: String, password: String){
        self.signInLoading = true
        auth.signIn(withEmail: email, password:password){[weak self] result, error in
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        self?.authError = "The email is already in use with another account"
                    case .userNotFound:
                        self?.authError = "Account not found for the specified user. Please check and try again"
                    case .userDisabled:
                        self?.authError = "Your account has been disabled. Please contact support."
                    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                        self?.authError = "Please enter a valid email"
                    case .networkError:
                        self?.authError = "Network error. Please try again."
                    case .weakPassword:
                        self?.authError = "Your password is too weak. The password must be 6 characters long or more."
                    case .wrongPassword:
                        self?.authError = "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
                    default:
                        self?.authError = "Unknown error occurred"
                    }
                }
            }
            guard result != nil, error == nil else {
                self?.signInLoading = false
                self?.showAlert = true
                
                return
            }
            DispatchQueue.main.async {
                self?.signInLoading = false
                self?.signedIn = true
            }
        }
    }
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
    func signUp(email: String, password: String, firstName: String, lastName: String){
        self.signInLoading = true
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            if error != nil, let error = error as NSError? {
                if let errorCode = AuthErrorCode(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        self?.authError = "The email is already in use with another account"
                    case .userNotFound:
                        self?.authError = "Account not found for the specified user. Please check and try again"
                    case .userDisabled:
                        self?.authError = "Your account has been disabled. Please contact support."
                    case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                        self?.authError = "Please enter a valid email"
                    case .networkError:
                        self?.authError = "Network error. Please try again."
                    case .weakPassword:
                        self?.authError = "Your password is too weak. The password must be 6 characters long or more."
                    case .wrongPassword:
                        self?.authError = "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
                    default:
                        self?.authError = "Unknown error occurred"
                    }
                }
            }
            guard result != nil, error == nil else {
                self?.signInLoading = false
                self?.showAlert = true
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users").document(result!.user.uid).setData([
                "firstName": firstName,
                "lastName": lastName,
                "uid": result!.user.uid,
                "friends": []
            ]) { err in
                if let err = err {
                    self?.signInLoading = false
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self?.signInLoading = false
                    DispatchQueue.main.async {
                        self?.signedIn = true
                    }
                }
            }
            
        }
    }
}
