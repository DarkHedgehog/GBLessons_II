//
//  DBGroup.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 06.07.2022.
//

import Foundation
import UIKit
import RealmSwift

class DBGroup: Object {
    @Persisted (primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var text: String
    @Persisted var imageURL: String?

    override init() {
        super.init()
    }

    required init(_ group: Group) {
        super.init()
        id = group.id
        imageURL = group.imageURL
        text = group.description
        name = group.name
    }

    public func toModel() -> Group {
        let result = Group(id: id, name: name, description: text, imageURL: imageURL)
        return result
    }
}
