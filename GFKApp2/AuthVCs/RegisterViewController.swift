//
//  RegisterViewController.swift
//  GFKApp
//
//  Created by Deniz Can Ilgın on 25.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//         Do any additional setup after loading the view.
    }
    

    @IBAction func GoLoginButtonAction(_ sender: Any) {
    

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    self.present(controller, animated: true, completion: nil)
    
    }
   

}
