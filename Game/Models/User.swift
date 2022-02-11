import Foundation

struct User: Codable {
    var id = UUID().uuidString
    
}

struct NonLocalUser: Identifiable, Codable {
    var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var friends: [String]?
}

