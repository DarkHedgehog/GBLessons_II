//
//  User.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 17.05.2022.
//

import Foundation
import UIKit

struct User {
    var id: String
    var image: UIImage?
    var name: String
    var groupIds: [String] = []
    var friendsIds: [String] = []
}
