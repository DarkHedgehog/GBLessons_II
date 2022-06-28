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
        ApiDataService.instance.getProfile { profile in
            // TODO: Сообщение об ошибке
            defer {
                // пока игнорим ошибки

                DispatchQueue.main.async() {
                    self.performSegue(withIdentifier: "Login2", sender: nil)
                }

            }
            guard let profile = profile else { return }

            StoredDataSourse.instance.profile = profile


        }
    }




    
}
