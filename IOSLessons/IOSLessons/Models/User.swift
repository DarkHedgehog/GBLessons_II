//
//  User.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 17.05.2022.
//

import Foundation
import UIKit



class ProfileResponse: Decodable {
    let user: User

    enum UserResponseLevel: String, CodingKey {
        case response1
        case first_name
        case last_name
        case id
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserResponseLevel.self)
        let responseContainer = try container.nestedContainer(keyedBy: UserResponseLevel.self, forKey: .response1)
        let firstName = try responseContainer.decode(String.self, forKey: .first_name)
        let lastName = try responseContainer.decode(String.self, forKey: .last_name)
        let id = try responseContainer.decode(Int.self, forKey: .id)

        self.user = User(id: id, firstName: firstName, lastName: lastName)
    }
}

class UsersResponse: Decodable {
    let users: [User]

    enum UsersResponseLevel: String, CodingKey {
        case response
        case items
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UsersResponseLevel.self)
        let responseContainer = try container.nestedContainer(keyedBy: UsersResponseLevel.self, forKey: .response)
        self.users = try responseContainer.decode([User].self, forKey: .items)
    }
}

struct User: Codable {
    var id: Int
    var image: UIImage?
    var imageURL: String?
    var fullname: String {
        "\(firstName) \(lastName)"
    }
    var firstName: String
    var lastName: String
    var groupIds: [String] = []
    var friendsIds: [Int] = []

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "photo_50"
    }

    init (id: Int, firstName: String, lastName: String) {
        self.id = id;
        self.firstName = firstName
        self.lastName = lastName

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}


//struct User {
//    var id: String
//    var image: UIImage?
//    var name: String
//    var groupIds: [String] = []
//    var friendsIds: [String] = []
//}
