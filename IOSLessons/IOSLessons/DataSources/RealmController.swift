//
//  RealmController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 06.07.2022.
//

import Foundation
import RealmSwift

final class RealmController {
    private let realm = try! Realm()
    static let instance = RealmController ()

    private init () {
        print(realm.configuration.fileURL ?? "fileURL is empty")
    }

    public func storeUser(_ user: Profile) throws {
        try realm.write {
            realm.add(DBProfile(user), update: .modified)
        }
    }

    public func storeGroup(_ group: Group) throws {
        try realm.write {
            realm.add(DBGroup(group), update: .modified)
        }
    }

    public func storeUserPost(_ post: UserPost) throws {
        try realm.write {
            realm.add(DBUserPost(post), update: .modified)
        }
    }
}
