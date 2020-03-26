//
//  LaunchScreenViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 19.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if(PFUser.current() != nil){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                    let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                                                    controller.modalPresentationStyle = .fullScreen
                                                    self.present(controller, animated: true, completion: nil)
            
        }else{
            
            //Do nothin and wit for login
            
        }

    }
    
    
    

}
