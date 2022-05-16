//
//  HomeData.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import Foundation
import UIKit

struct PersonRecord {
    var id: String
    var image: UIImage?
    var label: String
}

struct PersonImagesRecord {
    var personId: String
    var image: UIImage?
    var description: String
}

let personDataSource: [PersonRecord] = [
    PersonRecord(id: "0", image: UIImage.init(systemName: "sun.max.fill"), label: "Вася Пупкин"),
    PersonRecord(id: "1", image: UIImage.init(systemName: "person"), label: "Пупа Васькин"),
]

let personImagesDataSource: [PersonImagesRecord] = [
    PersonImagesRecord(personId: "0", image: UIImage.init(systemName: "externaldrive.fill.badge.person.crop"), description: "Люблю вареники"),
    PersonImagesRecord(personId: "0", image: UIImage.init(systemName: "person.fill.xmark"), description: "Не люблю Пупу"),
    PersonImagesRecord(personId: "0", image: UIImage.init(systemName: "person.fill.turn.left"), description: "Горизонт завален"),
    PersonImagesRecord(personId: "1", image: UIImage.init(systemName: "externaldrive.badge.person.crop"), description: "Вася у машины"),
    PersonImagesRecord(personId: "1", image: UIImage.init(systemName: "person.fill.badge.plus"), description: "Просто мужик"),
    PersonImagesRecord(personId: "1", image: UIImage.init(systemName: "shareplay"), description: "Радуга зацените"),
]
