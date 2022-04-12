import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    
    @Published var users = [NonLocalUser]()
    @Published var friends = [NonLocalUser]()
    @Published var currentUserInformation : NonLocalUser?
    @Published var userFriends = [String]()
    
    init() {
        fetchCurrentUser()
        fetchUsers()
    }
    //fetching users
    func fetchUsers() {
        let db = Firestore.firestore()
        guard let uid =  Auth.auth().currentUser?.uid else {
            return
        }
        guard var friends =  self.currentUserInformation?.friends else {
            return
        }
        friends.append(uid)
        
        var dbRef = friends.isEmpty ? db.collection("users").whereField("uid", isNotEqualTo: uid) : db.collection("users").whereField("uid", notIn: friends)
        
        
        dbRef.addSnapshotListener { (snapshot, error) in
            
            if let snapshot = snapshot {
                
                self.users = snapshot.documents.map { doc in
                    return NonLocalUser(id: doc.documentID,firstName: doc.data()["firstName"] as? String ?? "", lastName: doc.data()["lastName"] as? String ?? "", friends: doc.data()["friends"] as? [String] ?? [])
                    
                }
            }
            
        }
        self.fetchFriends()
        
    }
    //fetching friends
    func fetchFriends() {
        let db = Firestore.firestore()
        guard let uid =  Auth.auth().currentUser?.uid else {
            return
        }
        guard var friendsList =  self.currentUserInformation?.friends else {
            return
        }
        if friendsList.isEmpty {
            return
        }
        var dbRef = db.collection("users").whereField("uid", in: friendsList)
        
        dbRef.addSnapshotListener { (snapshot, error) in
            
            if let snapshot = snapshot {
                
                self.friends = snapshot.documents.map { doc in
                    return NonLocalUser(id: doc.documentID,firstName: doc.data()["firstName"] as? String ?? "", lastName: doc.data()["lastName"] as? String ?? "", friends:  doc.data()["friends"] as? [String] ?? [])
                    
                }
            }
            
        }
    }
    //fetching current users
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
            let friends = data["friends"] as? [String] ?? []
            self.currentUserInformation = NonLocalUser(id: uid,firstName: firstName, lastName: lastName, friends: friends)
            
            self.userFriends = friends
        }
        self.fetchUsers()
        
    }
    // function to update friends on cloud firestore
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
        self.fetchUsers()
       
    }
    // function to remove friends from friends list
    func removeFriends(friendId: String) {
        let db = Firestore.firestore()
        guard let uid =  Auth.auth().currentUser?.uid else {
            print("Could not find firebase uid")
            return
        }
        let userRef = db.collection("users").document(uid)
        userRef.updateData([
            "friends": FieldValue.arrayRemove([friendId])
        ])
        self.fetchUsers()
      
    }
}
