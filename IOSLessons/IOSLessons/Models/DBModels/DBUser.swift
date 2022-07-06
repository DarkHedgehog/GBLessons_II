//
//  Profile.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation
import UIKit
import RealmSwift

class DBUser: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var imageURL: String?
    @Persisted var firstName: String
    @Persisted var lastName: String

    override init() {
        super.init()
    }
    required init(_ user: User) {
        super.init()
        id = user.id
        imageURL = user.imageURL
        firstName = user.firstName
        lastName = user.lastName
    }

    public func toModel() -> User {
        var result = User(id: self.id, firstName: self.firstName, lastName: self.lastName)
        result.imageURL = imageURL
        return result
    }
}
