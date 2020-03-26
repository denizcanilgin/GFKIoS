//
//  FourthViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 29.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

var postIndex = 0
var listPostsGlobal = [PFObject]()
var listImageGlobal = [UIImage]()

var userProfileImageView:UIImage = #imageLiteral(resourceName: "ppdefault")

class FourthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var PPImageView: UIImageView!
    var tableView:UITableView!
 
           var listPosts = [PFObject]()
           var list = ["item1","item2","item3"]
           
       
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
          {
            self.tableView = tableView
            return (listPosts.count)
          }
       
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
          {
           let cellView = tableView.dequeueReusableCell(withIdentifier: "table_cell_blog",for: indexPath) as! BlogTableViewCell
           
            
            let title = listPosts[indexPath.row]["Title"] as? String
            let content = listPosts[indexPath.row]["Content"] as? String
            let image_url = listPosts[indexPath.row]["ImageUrl"] as? String
            
            cellView.cell_imageview_post.layer.cornerRadius = 15;
//            cellView.cell_imageview_post.clipsToBounds = YES;
            
     
            
            AF.request(image_url!).responseImage { response in
                debugPrint(response)

//                print(response.request)
//                print(response.response)
                debugPrint(response.result)

                if case .success(let image) = response.result {
                    print("image downloaded: \(image)")
                    cellView.cell_imageview_post.image = image
                    listImageGlobal.append(image)
                    
                }
            }
    
            
            cellView.cell_label_title.text = title
            cellView.cell_label_content.text = content
            
           self.tableView = tableView

           return (cellView)
           
          }
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
          // retrieveActivities()
        
        

        retrievePosts()
        retrieveUser()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.imageTapped(gesture:)))

               // add it to the image view;
               PPImageView.addGestureRecognizer(tapGesture)
               // make sure imageView can be interacted with by user
               PPImageView.isUserInteractionEnabled = true

       }
    
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
            // if the tapped view is a UIImageView then set it to imageview
            if (gesture.view as? UIImageView) != nil {
                print("Image Tapped")
                //Here you can initiate your new ViewController
                 showUserActionMenu(title: "Çıkış Yap",message: "Çıkış yapmak istediğinizden emin misiniz?")

          }}
    
    func showUserActionMenu(title:String,message:String){
         
          let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Çıkış Yap", style: .default, handler: { action in
                 
                 PFUser.logOut()
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                   let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                                   controller.modalPresentationStyle = .fullScreen
                                   self.present(controller, animated: true, completion: nil)
                 
                  
                }))
                alert.addAction(UIAlertAction(title: "Vazgeç", style: .default, handler: nil))
                self.present(alert, animated: true)
         
     }
     
    
 
    
 
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 350
       }
       
       func retrievePosts(){
           
           
           let query = PFQuery(className:"Post")
           query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
               if let error = error {
                   // Log details of the failure
                   print(error.localizedDescription)
               } else if let objects = objects {
                   // The find succeeded.
                   print("Successfully retrieved \(objects.count) scores.")
                   // Do something with the found objects
                   for object in objects {

                       self.listPosts.append(object)
               
                    self.tableView.reloadData()
                    
                   }
                   
                
                   
               }
           }
           
      
            
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        listPostsGlobal = self.listPosts
        
        print("pushedRow:" + String(indexPath.row) )
        postIndex = indexPath.row
        performSegue(withIdentifier: "postSegue", sender: self)
        
    }
    
    func retrieveUser(){
               
               let userId = PFUser.current()?.objectId
        
        if(userId != nil){
        
               let query = PFUser.query()
               query?.getObjectInBackground(withId: userId!){(user,error) in
       
                   if(error == nil){
       
                      
                       let photo = ((user?["Photo"] as? PFFileObject))
                     
                       photo?.getDataInBackground(block: { (data, error) in
                           
                           if(error == nil){
                               
                               let image = UIImage(data: data!)
                               if(image != nil){
                                
                                self.PPImageView.image = image
                                userProfileImageView = image!
                                self.PPImageView.setRounded()
                                                      
                                                   
                                                  }
                           }
                           
                       })
                    
       
                   }
       
               }
       
           
        }
               
           }

       
       
       func showAlert(title:String,message:String){
           
           let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)

           alert.addAction(UIAlertAction(title: "Anladım", style: .default, handler: nil))
           self.present(alert, animated: true)
           
       }
    
    
    func loadImage(imageView:UIImageView,urlkey:String){
          
    
           AF.request(urlkey).responseImage { response in
                          debugPrint(response)

                          debugPrint(response.result)

                          if case .success(let image) = response.result {
                              print("image downloaded: \(image)")
                            
                              imageView.image = image
                              
                          }
                      }
      
          
      }
    
    
    

    
}

    
    
    
    
    



