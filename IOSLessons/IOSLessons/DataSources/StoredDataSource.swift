//
//  StoredDataSource.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation

class StoredDataSourse {
    static let instance = StoredDataSourse()

    public var profile = Profile(
        id: 2342135,
        firstName: "Петр",
        lastName: "Петрович"
    )
}
