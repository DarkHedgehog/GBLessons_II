//
//  Profile.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation
import UIKit
import RealmSwift

class DBProfile: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var imageURL: String?
    @Persisted var firstName: String
    @Persisted var lastName: String
    @Persisted var groupIds: List<String>
    @Persisted var friendsIds: List<Int>

    override init() {
        super.init()
    }
    required init(_ profile: Profile) {
        super.init()
        id = profile.id
        imageURL = profile.imageURL
        firstName = profile.firstName
        lastName = profile.lastName
        groupIds = List<String>()
        groupIds.append(objectsIn: profile.groupIds)
        friendsIds = List<Int>()
        friendsIds.append(objectsIn: profile.friendsIds)
    }

    public func toModel() -> Profile {
        var result = Profile(id: self.id, firstName: self.firstName, lastName: self.lastName)
        result.imageURL = imageURL
        result.friendsIds = friendsIds.map( {$0} )
        result.groupIds = groupIds.map( {$0} )
        return result
    }
}
