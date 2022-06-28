//
//  ApiDataService.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 13.06.2022.
//

import Foundation
import UIKit

final class ApiDataService {

    static let instance = ApiDataService()

    public var profile = User(
        id: 2342135,
        firstName: "Петр",
        lastName: "Петрович"
//        first_name: "Петр",
//        last_name: "Петрович",
//        groupIds: ["1", "2"],
//        friendsIds: ["0", "1", "5"]
    )

    private var personsDataSource: [User] = [
//        User(id: "0", image: UIImage.init(systemName: "sun.max.fill"), name: "Вася Пупкин"),
//        User(id: "1", image: UIImage.init(systemName: "person"), name: "Пупа Васькин"),
//        User(id: "2", image: UIImage.init(systemName: "person"), name: "Василий Алибабаевич"),
//        User(id: "3", image: UIImage.init(systemName: "person"), name: "Иванов Алекс"),
//        User(id: "4", image: UIImage.init(systemName: "person"), name: "Кукота Владимир"),
//        User(id: "5", image: UIImage.init(systemName: "person"), name: "Нупин Влад"),
//        User(id: "6", image: UIImage.init(systemName: "person"), name: "Пунин Гладиолус"),
//        User(id: "7", image: UIImage.init(systemName: "person"), name: "Яковлев Жижа"),
//        User(id: "8", image: UIImage.init(systemName: "person"), name: "Гройсман Святослав"),
//        User(id: "9", image: UIImage.init(systemName: "person"), name: "Ковалев Моисей"),
//        User(id: "10", image: UIImage.init(systemName: "person"), name: "Крысоловов Боря"),
//        User(id: "11", image: UIImage.init(systemName: "person"), name: "Гнездов Алексей"),
    ]



    private var personImagesDataSource: [UserPost] = [
//        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", "nature-0x03", ], description: "Горизонт завален", likeCount: 10, isLiked: false),
//        UserPost(userId: "0", postImageNames: ["nature-0x04", "nature-0x05", ], description: "Горизонт завален", likeCount: 10, isLiked: false),
//        UserPost(userId: "0", postImageNames: ["nature-0x06", ], description: "Люблю вареники", likeCount: 1, isLiked: true),
//        UserPost(userId: "0", postImageNames: ["nature-0x07", "nature-0x08", "nature-0x09", "nature-0x0A", ], description: "Не люблю Пупу", likeCount: 20, isLiked: false),
//        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Вася у машины", likeCount: 321, isLiked: false),
//        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Просто мужик", likeCount: 100, isLiked: true),
//        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
//        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),

    ]


    private init() { }

    public func update() {
        updateProfile()
        updateFriends()
        updatePhotos()
        updateGroups()
        searchGroups(query: "qwer")
    }

    private func updateProfile() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getProfile.host
        urlComponents.path = VKApi.getProfile.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)

            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
                self.profile = response.user
            } catch {
                print(error)
            }
        }
        task.resume()
        
    }
    private func updateFriends() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getFriends.host
        urlComponents.path = VKApi.getFriends.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            guard let data = data else { return }
            do {
                let friendsResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
                self.personsDataSource = friendsResponse.users
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func updatePhotos() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getPhotos.host
        urlComponents.path = VKApi.getPhotos.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    private func updateGroups() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.getGroups.host
        urlComponents.path = VKApi.getGroups.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    private func searchGroups(query: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.searchGroups.host
        urlComponents.path = VKApi.searchGroups.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "filters", value: "groups"),
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.81") ]
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else { return }

            print(json)
        }
        task.resume()
    }

    // MARK: - Profile API
    public func getCurrentUser () -> User {
        return profile
    }

    public func addFriend(id: Int) {
        profile.friendsIds.append(id)
    }


    // MARK: - Users API
    public func getUser (id: Int) -> User? {
        return personsDataSource.first { user in 
            return user.id == id
        }
    }

    public func getUsers () -> [User] {
        return personsDataSource
    }

    // MARK: - Post API
    public func getPosts (userId: Int) -> [UserPost] {
        return personImagesDataSource.filter { $0.userId == userId }
    }

    // MARK: - Groups API
    public func getAvailableGroups () -> [Group] {

        let availableGroups: [Group] = [
            Group(id: "0", image: UIImage.init(systemName: "globe.europe.africa.fill"), name: "Диванные войска", description: "Ни дня без ругани"),
            Group(id: "1", image: UIImage.init(systemName: "heart.circle"), name: "Любовь-морковь", description: "Клуб любителей продолговатых предметов"),
            Group(id: "2", image: UIImage.init(systemName: "facemask.fill"), name: "Ковид", description: "Доколе?!!"),
            Group(id: "3", image: UIImage.init(systemName: "bag.circle"), name: "Сумки и круги", description: "Кидаем портфели в люки"),
            Group(id: "4", image: UIImage.init(systemName: "command"), name: "Macos и все-все-все", description: "Windows suxx"),
            Group(id: "5", image: UIImage.init(systemName: "seal.fill"), name: "Футбол и Россия", description: "Мяч виноват"),
        ]

        return availableGroups
    }
}
