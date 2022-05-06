//
//  UIViewController+Extension.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 03.05.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        present(alertViewController, animated: true)
    }
}
