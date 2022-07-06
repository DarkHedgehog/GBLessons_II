//
//  StoredDataSource.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation

class CurrentProfile {
    static let instance = CurrentProfile()

    public var profile = Profile(
        id: -1,
        firstName: "",
        lastName: ""
    )

    init () {
        RealmController.instance.getProfile(updateCache: false) { profile in
            guard let profile = profile else { return }
            self.profile = profile
        }
    }
}
