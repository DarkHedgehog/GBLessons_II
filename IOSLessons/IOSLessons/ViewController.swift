//
//  ViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 29.04.2022.
//

import UIKit




class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


    }

    @IBAction func signIn(_ sender: Any) {
        guard let login = loginField.text,
              let password = passwordField.text,
              login == "",
              password == "" else {
            showAlert(message: "incorrect login\\password")
            return
        }
        
        performSegue(withIdentifier: "Login", sender: nil)
    }

}

