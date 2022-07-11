//
//  StoredDataSource.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 28.06.2022.
//

import Foundation

class CurrentProfile {
    static let instance = CurrentProfile()

    private var cashedProfile: Profile?
    private var lastProfile: Profile?

    public var profile: Profile {
        get {
            return cashedProfile ?? Profile( id: -1, firstName: "", lastName: "")
        }
        set {
            cashedProfile = newValue
            FirebaseController.instance.storeData(path:"Profile",
                                                  id:newValue.id,
                                                  data: newValue.toAnyObject)
        }
    }

    init () {
        FirebaseController.instance.performAuth(email: "aaa@aaa.aaa", password: "aaa@aaa.aaa")

        RealmController.instance.getProfile(updateCache: false) { profile in
            guard let profile = profile else { return }
            self.profile = profile

            FirebaseController.instance.loadData(path: "Profile", id: profile.id) { profile in
                guard let profile = profile else { return }
                print (profile)
            }
        }




    }

}
