//
//  FireBaseController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 11.07.2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class FirebaseController {

    fileprivate let databaseUrl = "https://gblessons-c62ff-default-rtdb.europe-west1.firebasedatabase.app/"

    static let instance = FirebaseController ()


    private init () {
        FirebaseApp.configure()
    }

    public func performAuth(email: String, password: String ) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        }
    }

    public func storeData(path: String, id: Int, data: Any) {
        let dbLink = Database.database(url: databaseUrl).reference()
        dbLink.child(path).child(String(id)).setValue(data)
    }

    public func loadData(path: String, id: Int, _ completion: @escaping ((Any?) -> Void)) {
        let dbLink = Database.database(url: databaseUrl).reference()
        _ = dbLink.child(path).child(String(id)).observe(DataEventType.value, with: { snapshot in
            completion(snapshot.value)
        })
    }

}

