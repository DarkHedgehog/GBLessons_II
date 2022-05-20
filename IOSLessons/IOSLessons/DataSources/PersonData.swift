//
//  HomeData.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import Foundation
import UIKit



let personDataSource: [User] = [
    User(id: "0", image: UIImage.init(systemName: "sun.max.fill"), name: "Вася Пупкин"),
    User(id: "1", image: UIImage.init(systemName: "person"), name: "Пупа Васькин"),
]

let personImagesDataSource: [UserPost] = [
    UserPost(personId: "0", image: UIImage.init(systemName: "person.fill.turn.left"), description: "Горизонт завален", likeCount: 10, isLiked: false),
    UserPost(personId: "0", image: UIImage.init(systemName: "externaldrive.fill.badge.person.crop"), description: "Люблю вареники", likeCount: 1, isLiked: true),
    UserPost(personId: "0", image: UIImage.init(systemName: "person.fill.xmark"), description: "Не люблю Пупу", likeCount: 20, isLiked: false),
    UserPost(personId: "1", image: UIImage.init(systemName: "externaldrive.badge.person.crop"), description: "Вася у машины", likeCount: 321, isLiked: false),
    UserPost(personId: "1", image: UIImage.init(systemName: "person.fill.badge.plus"), description: "Просто мужик", likeCount: 100, isLiked: true),
    UserPost(personId: "1", image: UIImage.init(systemName: "shareplay"), description: "Радуга зацените", likeCount: 100, isLiked: false),
]
