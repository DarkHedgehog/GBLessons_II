//
//  VKLoadViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 16.06.2022.
//

import UIKit

class VKLoadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RealmController.instance.getProfile(updateCache: false) { profile in
            debugPrint(profile ?? "profile empty")
            self.performSegue(withIdentifier: "Login2", sender: nil)
        }
    }
}
