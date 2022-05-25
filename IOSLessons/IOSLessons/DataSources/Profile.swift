//
//  Profile.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 17.05.2022.
//

import Foundation
import UIKit

var currentUser = UserProfile()

final class UserProfile {
    var profile = User(
        id: "2342135",
        image: UIImage(systemName: "person.fill.checkmark"),
        name: "Петр Петрович",
        groupIds: ["1", "2"],
        friendsIds: ["1", "3", "5"]

    )

    func addFriend(id: String) {
        profile.friendsIds.append(id)
    }
}


