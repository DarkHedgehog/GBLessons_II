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
        ApiDataService.instance.update()
    }




    
}
