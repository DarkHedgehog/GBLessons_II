//
//  HomeData.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import Foundation
import UIKit



let personDataSource: [User] = [
    User(id: "0", image: UIImage.init(systemName: "sun.max.fill"), label: "Вася Пупкин"),
    User(id: "1", image: UIImage.init(systemName: "person"), label: "Пупа Васькин"),
]

let personImagesDataSource: [UserPost] = [
    UserPost(personId: "0", image: UIImage.init(systemName: "person.fill.turn.left"), description: "Горизонт завален"),
    UserPost(personId: "0", image: UIImage.init(systemName: "externaldrive.fill.badge.person.crop"), description: "Люблю вареники"),
    UserPost(personId: "0", image: UIImage.init(systemName: "person.fill.xmark"), description: "Не люблю Пупу"),
    UserPost(personId: "1", image: UIImage.init(systemName: "externaldrive.badge.person.crop"), description: "Вася у машины"),
    UserPost(personId: "1", image: UIImage.init(systemName: "person.fill.badge.plus"), description: "Просто мужик"),
    UserPost(personId: "1", image: UIImage.init(systemName: "shareplay"), description: "Радуга зацените"),
]
