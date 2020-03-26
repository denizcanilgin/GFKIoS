//
//  CustomEventViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 10.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

var listTasksGlobal2 = [PFObject]()

class CustomEventViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
        
    @IBOutlet weak var PPImageView: UIImageView!
    var tableView:UITableView!
        var listTasks = [PFObject]()
        

        
    //    var numberOfRegisteredAtendees = 0
    //    var maxNumberOfAtendees = 0
            
        
           func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
           {
            self.tableView = tableView
            return (listTasks.count)
           }
        
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
           {
        
            
            let cellView = tableView.dequeueReusableCell(withIdentifier: "cell_view_custom_task",for: indexPath) as! CustomEventViewCell
            
            if(indexPath.row  <= listTasks.count){
                let object = listTasks[indexPath.row];
                let title = object["Title"] as? String
                let point = object["Point"] as? Int
                
            
                let listOfTakers = object["ListTakers"] as? Array<PFUser>
                if(listOfTakers != nil){
                   
                }else{
            }
                
                cellView.LabelTitle.text = title
                cellView.LabelPoint.text = "\(point ?? 50)"
                cellView.LabelPoint.layer.cornerRadius = 10.0
                cellView.LabelPoint.clipsToBounds = true
                
                
//                cellView.cell_label_capacity.text = "\(numberOfTakers ?? 0)" + " / " + "\(maxNumberOfTakers ?? 0)"
            
                
            
            }
        
        
            return cellView
            
           }
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
//            retrieveActivities()
//
            
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
        return 80
    }
        
    
        
        func retrieveActivities(){
            
            self.listTasks.removeAll()

            
            let query = PFQuery(className:"Activity")
            query.whereKey("Type", equalTo: 5)
            query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                if let error = error {
                    // Log details of the failure
                    print(error.localizedDescription)
                } else if let objects = objects {
                    // The find succeeded.
                    print("Successfully retrieved \(objects.count) scores.")
                    // Do something with the found objects
                    for object in objects {

                        self.listTasks.append(object)
                        listTasksGlobal2.append(object)
                        self.tableView.reloadData()
                        
                    }
                    
                        
                        self.tableView.reloadData()
                    
                    
                }
            }
            
       
             
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
            if(listTasks.count > indexPath.row){
                let pfTask = listTasks[indexPath.row]
           
                 let maxNumberOfTakers = pfTask["MaxNumberOfTakers"] as! Int
                 let listTakers = pfTask["NumberOfTakers"] as? Array<PFUser>
                 
                 var numberOfTakers = 0
                 if(listTakers != nil){
                        numberOfTakers = listTakers!.count
                 }
            
            if(numberOfTakers < maxNumberOfTakers)
            {
                
                
                print("Tıklandı!")
//                checkUserIsAlreadyRegistered(pfTask: listTasks[indexPath.row], indexPath: indexPath.row)
                incrementRegisteredNumberOfAtendeesByOne2(indexPath: indexPath.row)

                  
            }else{
                
                showAlert(title: "Kontenjan Dolu!", message: "Katılmak istediğiniz etkinliğin kontonjanı doludur.")
                
            }
                
            
                
            }
          }
        
        
        func showAlert(title:String,message:String){
            
            let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Anladım", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
        
        func incrementRegisteredNumberOfAtendeesByOne2(indexPath:Int){
            
                let pfTask = self.listTasks[indexPath]
               
            if(pfTask["ListTakers"]  == nil){
                //If Array is comletely nil and nobody is registered before create new array and save
                print("arrayIsNull")
                var listTakers = [PFUser]()
                listTakers.append(PFUser.current()!)
                pfTask["ListTakers"] = listTakers
            }else{
                //If someone already registered, just add new one and save
                var listTakers =  pfTask["ListTakers"] as? Array<PFUser>
                listTakers?.append(PFUser.current()!)
                pfTask["ListTakers"] = listTakers
            }
            
        
                pfTask.saveInBackground(){(succeeded, error) in
                
                if(error == nil){
                    
                    print("incrementNumberOfAtendees: " + "succeed!")
                    print("pushedRow:" + String(indexPath) )
                                  listTasksGlobalIndex = indexPath
                    self.performSegue(withIdentifier: "registeredSeguer2", sender: self)
                    self.retrieveActivities()
                    
                }
                
            }
                
            
        }
        
       
        override func viewDidAppear(_ animated: Bool) {
                   retrieveActivities()
            
            PPImageView.image = userProfileImageView
            PPImageView.setRounded()
            
               }

        

}
