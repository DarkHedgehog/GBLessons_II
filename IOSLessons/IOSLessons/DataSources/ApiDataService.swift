//
//  ApiDataService.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 13.06.2022.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

final class ApiDataService {

    static let instance = ApiDataService()   

    @available(*, deprecated, message: "Rework this to api")
    private var personsDataSource: [Profile] = []

    @available(*, deprecated, message: "Rework this to api")
    private var personImagesDataSource: [UserPost] = []


    private init() { }



    @available(*, deprecated, message: "Rework this to search")
    public func getAvailableGroups () -> [Group] {

        let availableGroups: [Group] = [
        ]

        return availableGroups
    }

    // MARK: - Profile API

    /// Возвращает текущий профиль
    public func getProfile( _ completion: @escaping (Profile?) -> Void ) {

        var profile = Profile(id: -1, firstName: "", lastName: "")

        let group = DispatchGroup()
        group.enter()
        DispatchQueue.global().async {
            self.getProfileBase { profileBase in
                defer { group.leave() }
                guard let profileBase = profileBase else { return }
                profile.id = profileBase.id
                profile.lastName = profileBase.lastName
                profile.firstName = profileBase.firstName
            }
        }
        group.enter()
        DispatchQueue.global().async {
            self.getProfilePhoto { photoUrl in
                defer { group.leave() }
                guard let photoUrl = photoUrl else { return }
                profile.imageURL = photoUrl
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            completion (profile)
        }

    }
    
    // MARK: - Friends
    /// Возвращает друзей текущего профиля
    public func getFriends( _ completion: @escaping ([Profile]?) -> Void ) {
        let queryParams = [
            URLQueryItem(name: "fields", value: "photo_100,nickname"),
        ]

        guard let requestURL = makeUrl(method: VKApi.getFriends, params: queryParams) else {
            completion(nil)
            return
        }

        AF.request(requestURL).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }

            do {
                let json = try JSON(data: data)
                let responseObject = json["response"]
                let items = responseObject["items"].arrayValue

                var result = [Profile]()

                for item in items {
                    let id = item["id"].intValue
                    let firstName = item["first_name"].stringValue
                    let lastName = item["last_name"].stringValue
                    var friend = Profile(id: id, firstName: firstName, lastName: lastName)
                    friend.imageURL = item["photo_100"].stringValue
                    if firstName != "DELETED" {
                        result.append(friend)
                    }
                }

                completion(result)

            } catch {
                completion(nil)
                return
            }
        }
    }

    public func getFriendPosts(userId: Int,  _ completion: @escaping ([UserPost]?) -> Void ) {
        let queryParams = [
            URLQueryItem(name: "owner_id", value: String(userId)),
            URLQueryItem(name: "filter", value: "owner"),
        ]

        guard let requestURL = makeUrl(method: VKApi.getPosts, params: queryParams) else {
            completion(nil)
            return
        }

        AF.request(requestURL).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }

            do {
                let json = try JSON(data: data)
                let responseObject = json["response"]
                let items = responseObject["items"].arrayValue

                var result = [UserPost]()

                for item in items {
                    let id = item["id"].intValue
                    let userId = item["owner_id"].intValue
                    let likes = item["likes"]["count"].intValue
                    let text = item["text"].stringValue
                    let date = item["date"].intValue
                    let attachments = item["attachments"].arrayValue.filter( { !$0["photo"].isEmpty} )
                    if attachments.count > 0 {
                        let imageUrls = attachments.map ({
                            $0["photo"]["sizes"].arrayValue.first(where: { $0["type"] == "x"})?["url"].stringValue ?? ""
                        })
                        let post = UserPost(id: id,
                                            userId: userId,
                                            date: date,
                                            text: text,
                                            imageUrls: imageUrls,
                                            likeCount: likes,
                                            isLiked: false)
                        result.append(post)
                    }
                }

                completion(result)

            } catch {
                completion(nil)
                return
            }
        }
    }

    // MARK: - Groups
    /// Возвращает группы текущего профиля
    public func getProfileGroups( _ completion: @escaping ([Group]?) -> Void ) {
        let queryParams = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
        ]

        guard let requestURL = makeUrl(method: VKApi.getGroups, params: queryParams) else {
            completion(nil)
            return
        }

        AF.request(requestURL).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }

            do {
                let json = try JSON(data: data)
                let responseObject = json["response"]
                let items = responseObject["items"].arrayValue
                debugPrint(json)
                var result = [Group]()

                for item in items {
                    debugPrint(item)
                    let id = item["id"].intValue
                    let name = item["name"].stringValue
                    let description = item["description"].stringValue
                    var group = Group(id: id, name: name, description: description)
                    group.imageURL = item["photo_100"].stringValue
                    if name != "DELETED" {
                        result.append(group)
                    }
                }

                completion(result)

            } catch {
                completion(nil)
                return
            }
        }
    }

    public func addGroup(_ id: Int, _ completion: @escaping (Bool) -> Void ) {
        completion(true)
    }

    public func leaveGroup(_ id: Int, _ completion: @escaping (Bool) -> Void ) {
        completion(true)
    }


    //    private func searchGroups(query: String) {
    //        var urlComponents = URLComponents()
    //        urlComponents.scheme = "https"
    //        urlComponents.host = VKApi.searchGroups.host
    //        urlComponents.path = VKApi.searchGroups.endPoint
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "q", value: query),
    //            URLQueryItem(name: "filters", value: "groups"),
    //            URLQueryItem(name: "access_token", value: Session.instance.token),
    //            URLQueryItem(name: "v", value: "5.81") ]
    //        let request = URLRequest(url: urlComponents.url!)
    //        let session = URLSession.shared
    //        let task = session.dataTask(with: request) { (data, response, error) in
    //            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }
    //
    //            print(json)
    //        }
    //        task.resume()
    //    }


    public func addFriend(id: Int) {
//        profile.friendsIds.append(id)
    }

    @available(*, deprecated, message: "Rework this to api")
    public func getUsers () -> [Profile] {
        return personsDataSource
    }




    // MARK: - privates

    /// Создает урл с заданными параметрами, с версией VKAPI по умолчанию и ранее сохранненным токеном
    private func makeUrl( method: VKApi, params: [URLQueryItem] = []) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = method.host
        urlComponents.path = method.endPoint
        var queryItems = params

        if queryItems.first(where: {$0.name == "v"}) == nil {
            queryItems.append(URLQueryItem(name: "v", value: "5.81"))
        }
        if queryItems.first(where: {$0.name == "access_token"}) == nil {
            queryItems.append(URLQueryItem(name: "access_token", value: Session.instance.token))
        }

        urlComponents.queryItems = queryItems

        return urlComponents.url
    }

    /// возвращает первое фото для профиля
    private func getProfilePhoto(_ completion: @escaping (String?) -> Void ) {
        let queryParams = [
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "count", value: "1")
        ]
        guard let profilePhotoURL = makeUrl(method: VKApi.getPhotos, params: queryParams) else {
            completion(nil)
            return
        }

        AF.request(profilePhotoURL).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }

            do {
                let json = try JSON(data: data)
                let responseObject = json["response"]
                let items = responseObject["items"].arrayValue

                if items.count > 0,
                   let xSizeImage = items[0]["sizes"].arrayValue.first(where: {$0["type"] == "x"}) {
                    let imageURL = xSizeImage["url"].stringValue
                    completion(imageURL)
                    return
                }

            } catch {
                completion(nil)
                return
            }
            completion(nil)
        }
    }

    /// возвращает профиль, заполненный методом method: VKApi.getProfileInfo (без фото)
    private func getProfileBase(_ completion: @escaping (Profile?) -> Void ) {
        guard let profileURL = makeUrl(method: VKApi.getProfileInfo) else {
            completion(nil)
            return
        }

        AF.request(profileURL).response { response in
            guard let data = response.data else {
                completion(nil)
                return
            }

            do {
                let json = try JSON(data: data)
                let responseObject = json["response"]
                let id = responseObject["id"].intValue
                let firstName = responseObject["first_name"].stringValue
                let lastName = responseObject["last_name"].stringValue

                let profile = Profile(id: id, firstName: firstName, lastName: lastName)
                completion(profile)

            } catch {
                completion(nil)
                return
            }
        }

    }
}
