//
//  RealmController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 06.07.2022.
//

import Foundation
import RealmSwift

final class RealmController {
    private let realm: Realm?
    static let instance = RealmController ()

    private init () {
        do {
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.deleteRealmIfMigrationNeeded = true
            realm = try Realm(configuration: configuration)
        } catch {
            realm = nil
            debugPrint(error)
            return
        }
        print(realm?.configuration.fileURL ?? "fileURL is empty")
    }

    // MARK: - Profile routine

    public func storeProfile(_ profile: Profile) throws {
        guard let realm = realm else { return }
        try realm.write {
            realm.add(DBProfile(profile), update: .modified)
        }
    }

    /// Возвращает профиль ВК
    /// - Parameters:
    ///   - updateCache: true - обновить  профиль с удаленного сайта
    ///   - completion: completion
    public func getProfile(updateCache: Bool = true, _ completion: @escaping (Profile?) -> Void ) {
        guard let realm = realm else { return }

        if updateCache {
            ApiDataService.instance.getProfile { profile in
                guard let profile = profile else {
                    returnProfileFromDb()
                    return
                }
                DispatchQueue.main.async() {
                    do {
                        try self.storeProfile(profile)
                    } catch {

                    }
                    returnProfileFromDb()
                }
            }
        } else {
            returnProfileFromDb()
        }

        func returnProfileFromDb() {
            let dbProfile = realm.object(ofType: DBProfile.self, forPrimaryKey: DBProfile.profilePrimariId)
            let profile = dbProfile?.toModel() ?? Profile.init(id: -1, firstName: "John", lastName: "Doe")
            completion(profile)
        }
    }

    // MARK: - Friends

    public func storeFriends (_ users: [User]) throws {
        guard let realm = realm else { return }
        let dbUsers = users.map { DBUser($0) }
        try realm.write {
            realm.add(dbUsers, update: .modified)
        }
    }

    public func storeUser(_ user: User) throws {
        guard let realm = realm else { return }
        try realm.write {
            realm.add(DBUser(user), update: .modified)
        }
    }

    public func getFriendsSubscription(updateCache: Bool = true, _ completion: @escaping (RealmCollectionChange<Results<DBUser>>) -> Void ) -> NotificationToken? {
        guard let realm = realm else { return nil}

        let notificationToken = realm.objects(DBUser.self).observe { change in
                completion(change)
        }

        if updateCache {
            ApiDataService.instance.getFriends { users in
                guard let users = users else { return }
                DispatchQueue.main.async() {
                    do {
                        try self.storeFriends(users)
                    } catch {

                    }
                }
            }
        }
        return notificationToken
    }

    public func getFriends(updateCache: Bool = true, _ completion: @escaping ([User]?) -> Void ) {
        guard let realm = realm else { return }

        if updateCache {
            ApiDataService.instance.getFriends { users in
                guard let users = users else {
                    returnFriendsFromDb()
                    return
                }
                DispatchQueue.main.async() {
                    do {
                        try self.storeFriends(users)
                    } catch {

                    }
                    returnFriendsFromDb()
                }
            }
        } else {
            returnFriendsFromDb()
        }


        func returnFriendsFromDb() {
            let users = Array(realm.objects(DBUser.self).map { $0.toModel() })
            completion(users)
        }
    }

    // MARK: - Posts

    public func storeUserPost(_ post: UserPost) throws {
        guard let realm = realm else { return }
        try realm.write {
            realm.add(DBUserPost(post), update: .modified)
        }
    }

    public func storeUserPosts(_ posts: [UserPost]) throws {
        guard let realm = realm else { return }
        let dbPosts = posts.map { DBUserPost($0) }
        try realm.write {
            realm.add(dbPosts, update: .modified)
        }
    }

    public func getFriendPosts(userId: Int, updateCache: Bool = true, _ completion: @escaping ([UserPost]?) -> Void ) {
        guard let realm = realm else { return }

        if updateCache {
            ApiDataService.instance.getFriendPosts(userId: userId) { posts in
                guard let posts = posts else {
                    returnPostsFromDb()
                    return
                }
                DispatchQueue.main.async() {
                    do {
                        try self.storeUserPosts(posts)
                    } catch {

                    }
                    returnPostsFromDb()
                }
            }
        } else {
            returnPostsFromDb()
        }

        func returnPostsFromDb() {
            let posts = Array(realm.objects(DBUserPost.self)
                .where{ $0.userId == userId }
                .map { $0.toModel() })
            completion(posts)
        }
    }

    // MARK: - Groups

    public func storeGroup(_ group: Group) throws {
        guard let realm = realm else { return }
        try realm.write {
            realm.add(DBGroup(group), update: .modified)
        }
    }

    public func storeGroups(_ groups: [Group]) throws {
        guard let realm = realm else { return }
        let dbGroups = groups.map { DBGroup($0) }
        try realm.write {
            realm.add(dbGroups, update: .modified)
        }
    }

    public func getGroups(updateCache: Bool = true, _ completion: @escaping ([Group]?) -> Void ) {
        guard let realm = realm else { return }

        if updateCache {
            ApiDataService.instance.getProfileGroups { groups in
                guard let groups = groups else {
                    returnGroupsFromDb()
                    return
                }
                DispatchQueue.main.async() {
                    do {
                        try self.storeGroups(groups)
                    } catch {

                    }
                    returnGroupsFromDb()
                }
            }
        } else {
            returnGroupsFromDb()
        }

        func returnGroupsFromDb() {
            let groups = Array(realm.objects(DBGroup.self)
                .map { $0.toModel() })
            completion(groups)
        }
    }

}
