//
//  ProfileViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 2.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var ImageViewProfilePhoto: UIImageView!
    @IBOutlet weak var TextFieldFullName: UITextField!
    @IBOutlet weak var TextFieldTitle: UITextField!
    @IBOutlet weak var TextFieldSchool: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            ImageViewProfilePhoto.layer.cornerRadius = 15;
            ImageViewProfilePhoto.image = #imageLiteral(resourceName: "ppdefault")
            
            retrieveAndFillProfileIfNotEmpty()
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            retrieveAndFillProfileIfNotEmpty()
        }
    
    @IBAction func SaveProfileAction(_ sender: Any) {
        
        let entered_full_name = TextFieldFullName.text
        let entered_title = TextFieldTitle.text
        let entered_school = TextFieldSchool.text
        
          let userId = PFUser.current()?.objectId
          var query = PFUser.query()
                query?.getObjectInBackground(withId: userId!){(user,error) in
        
                    if(error == nil){

                        user?["full_name"] = entered_full_name
                        user?["title"] = entered_title
                        user?["school"] = entered_school
                
                        user?.saveInBackground { (succeeded, error)  in
                            if (succeeded) {
                                // The object has been saved.
                                print("UserProfileSuccessFullySaved!")
                                self.showAlert(title: "Başarılı!", message: "Profiliniz başarıyla güncellendi!")
                                
                                
                            } else {
                                // There was a problem, check error.description
                                
                                self.showAlert(title: "Başarısız!", message: "Profiliniz güncellenirken bir hata meydana geldi")
                                                              
                                
                            }
                        }
                        
                    }
        
                }
        
        
    }
    
        func retrieveAndFillProfileIfNotEmpty(){
            
            let userId = PFUser.current()?.objectId
            var query = PFUser.query()
            query?.getObjectInBackground(withId: userId!){(user,error) in
    
                if(error == nil){
    
                    let full_name = ((user?["full_name"] as? String))
                    let title = ((user?["title"] as? String))
                    let school = ((user?["school"] as? String))
    
                    if(full_name != nil){
                        self.TextFieldFullName.text = full_name
                        print("UserRetrievedSuccessfully:" + full_name!)}
    
                    if(title != nil){
                        self.TextFieldTitle.text = title
                        print("UserRetrievedSuccessfully:" + title!)}
    
                    if(school != nil){
                        self.TextFieldSchool.text = school
                        print("UserRetrievedSuccessfully:" + school!)}
    
    
    
                }
    
            }
    
        

            
        }
    
    func showAlert(title:String,message:String){
          
          let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "Anladım", style: .default, handler: nil))
          self.present(alert, animated: true)
          
      }

}
