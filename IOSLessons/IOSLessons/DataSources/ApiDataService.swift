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

    private var profile = User(
        id: "2342135",
        image: UIImage.init(systemName: "person.fill.checkmark"),
        name: "Петр Петрович",
        groupIds: ["1", "2"],
        friendsIds: ["0", "1", "5"]
    )

    private let personsDataSource: [User] = [
        User(id: "0", image: UIImage.init(systemName: "sun.max.fill"), name: "Вася Пупкин"),
        User(id: "1", image: UIImage.init(systemName: "person"), name: "Пупа Васькин"),
        User(id: "2", image: UIImage.init(systemName: "person"), name: "Василий Алибабаевич"),
        User(id: "3", image: UIImage.init(systemName: "person"), name: "Иванов Алекс"),
        User(id: "4", image: UIImage.init(systemName: "person"), name: "Кукота Владимир"),
        User(id: "5", image: UIImage.init(systemName: "person"), name: "Нупин Влад"),
        User(id: "6", image: UIImage.init(systemName: "person"), name: "Пунин Гладиолус"),
        User(id: "7", image: UIImage.init(systemName: "person"), name: "Яковлев Жижа"),
        User(id: "8", image: UIImage.init(systemName: "person"), name: "Гройсман Святослав"),
        User(id: "9", image: UIImage.init(systemName: "person"), name: "Ковалев Моисей"),
        User(id: "10", image: UIImage.init(systemName: "person"), name: "Крысоловов Боря"),
        User(id: "11", image: UIImage.init(systemName: "person"), name: "Гнездов Алексей"),
    ]



    private let personImagesDataSource: [UserPost] = [
        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", "nature-0x03", ], description: "Горизонт завален", likeCount: 10, isLiked: false),
        UserPost(userId: "0", postImageNames: ["nature-0x04", "nature-0x05", ], description: "Горизонт завален", likeCount: 10, isLiked: false),
        UserPost(userId: "0", postImageNames: ["nature-0x06", ], description: "Люблю вареники", likeCount: 1, isLiked: true),
        UserPost(userId: "0", postImageNames: ["nature-0x07", "nature-0x08", "nature-0x09", "nature-0x0A", ], description: "Не люблю Пупу", likeCount: 20, isLiked: false),
        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Вася у машины", likeCount: 321, isLiked: false),
        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Просто мужик", likeCount: 100, isLiked: true),
        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "1", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "5", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),
        UserPost(userId: "0", postImageNames: ["nature-0x01", "nature-0x02", ], description: "Радуга зацените", likeCount: 100, isLiked: false),

    ]


    private init() { }


    // MARK: - Profile API
    public func getCurrentUser () -> User {
        return profile
    }

    public func addFriend(id: String) {
        profile.friendsIds.append(id)
    }

    // MARK: - Users API
    public func getUser (id: String) -> User? {
        return personsDataSource.first { user in 
            return user.id == id
        }
    }

    public func getUsers () -> [User] {
        return personsDataSource
    }

    // MARK: - Post API
    public func getPosts (userId: String) -> [UserPost] {
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
