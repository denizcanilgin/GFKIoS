//
//  MainTabBarViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 19.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  checkUserAlreadyLoggedIn()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserAlreadyLoggedIn()
    }
    
     func checkUserAlreadyLoggedIn(){
            
                  
                       if(PFUser.current() == nil){
                        
//                        print("currentUser:" + PFUser.current()!.objectId!)
                        
    //                    self.performSegue(withIdentifier: "alreadyLoggedInSegue", sender: self)
                        
                                   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                   let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                                                   controller.modalPresentationStyle = .fullScreen
                                                   self.present(controller, animated: true, completion: nil)
                                                         
                        
                                 
                             }else{
                                 
                        
                         print("currentUser:" + "nil")
                                 //Do nothin and wit for login
                                   
                           
                                 
                       
                   }
                  
              }
    
    
   
    
   
}
