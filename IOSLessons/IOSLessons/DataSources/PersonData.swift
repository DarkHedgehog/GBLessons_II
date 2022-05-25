//
//  HomeData.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import Foundation
import UIKit



let personsDataSource: [User] = [
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

let personImagesDataSource: [UserPost] = [
    UserPost(personId: "0", image: UIImage(named: "nature-0x01"), description: "Горизонт завален", likeCount: 10, isLiked: false),
    UserPost(personId: "0", image: UIImage(named: "nature-0x02"), description: "Горизонт завален", likeCount: 10, isLiked: false),
    UserPost(personId: "0", image: UIImage(named: "nature-0x03"), description: "Люблю вареники", likeCount: 1, isLiked: true),
    UserPost(personId: "0", image: UIImage(named: "nature-0x04"), description: "Не люблю Пупу", likeCount: 20, isLiked: false),
    UserPost(personId: "1", image: UIImage(named: "nature-0x05"), description: "Вася у машины", likeCount: 321, isLiked: false),
    UserPost(personId: "1", image: UIImage(named: "nature-0x06"),  description: "Просто мужик", likeCount: 100, isLiked: true),
    UserPost(personId: "1", image: UIImage(named: "nature-0x07"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "1", image: UIImage(named: "nature-0x08"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "5", image: UIImage(named: "nature-0x09"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "5", image: UIImage(named: "nature-0x0A"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "5", image: UIImage(named: "nature-0x0B"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "5", image: UIImage(named: "nature-0x0C"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "0", image: UIImage(named: "nature-0x0D"),  description: "Радуга зацените", likeCount: 100, isLiked: false),
    UserPost(personId: "0", image: UIImage(named: "nature-0x0E"),  description: "Радуга зацените", likeCount: 100, isLiked: false),

]
