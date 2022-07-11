//
//  Profile.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation
import UIKit

struct Profile {
    var id: Int
    var imageURL: String?
    var fullname: String {
        "\(firstName) \(lastName)"
    }
    var firstName: String
    var lastName: String
    var groupIds: [String] = []
    var friendsIds: [Int] = []

    var toAnyObject: Any {
            return [
                "id": id,
                "name": fullname,
                "groups": groupIds
    ] }
}
