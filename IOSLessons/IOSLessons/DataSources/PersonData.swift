//
//  HomeData.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.05.2022.
//

import Foundation
import UIKit

struct PersonRecord {
    var image: UIImage?
    var label: String
}

let personDataSource: [PersonRecord] = [
    PersonRecord(image: UIImage.init(systemName: "sun.max.fill"), label: "Вася Пупкин"),
    PersonRecord(image: UIImage.init(systemName: "person"), label: "Пупа Васькин"),
]
