import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    
    @Published var users = [NonLocalUser]()
    @Published var currentUser : NonLocalUser? = nil
    @Published var currentUserInformation : NonLocalUser?
    
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                let id = i.documentID
                let firstName = i.get("firstName") as! String
                let lastName = i.get("lastName") as! String
                let friends = i.get("friends") as? [String]
                
                self.users.append(NonLocalUser(id: id,firstName: firstName, lastName: lastName, friends: friends))
                
            }
        }
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        let database = Firestore.firestore()
        guard let uid =  Auth.auth().currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        
        database.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch current user:", error)
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found")
                return
                
            }
            let uid = snapshot?.documentID ?? ""
            let firstName = data["firstName"] as? String ?? ""
            let lastName = data["lastName"] as? String ?? ""
            let friends = data["friends"] as? [String]
            self.currentUserInformation = NonLocalUser(id: uid,firstName: firstName, lastName: lastName, friends: friends)
        }
        
    }
    
    func updateFriends(friendId: String) {
        let db = Firestore.firestore()
        guard let uid =  Auth.auth().currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        let userRef = db.collection("users").document(uid)
        userRef.updateData([
            "friends": FieldValue.arrayUnion([friendId])
        ])
    }
    
   
}
