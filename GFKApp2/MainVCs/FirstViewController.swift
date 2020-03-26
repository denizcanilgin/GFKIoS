//
//  FirstViewController.swift
//  GFKApp
//
//  Created by Deniz Can Ilgın on 25.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

var listTasksGlobal = [PFObject]()
var listTasksGlobalIndex = 0

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var PPImageView: UIImageView!
    
    var tableView:UITableView!
    var listTasks = [PFObject]()

    
//    var numberOfRegisteredAtendees = 0
//    var maxNumberOfAtendees = 0
        
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
       {
        self.tableView = tableView
        return (self.listTasks.count)
       }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        
    
        
        let cellView = tableView.dequeueReusableCell(withIdentifier: "table_cell_task",for: indexPath) as! TasksTableViewCell
        
        if(indexPath.row  <= self.listTasks.count){
            let object = self.listTasks[indexPath.row];
            let title = object["Title"] as? String
            let point = object["Point"] as? Int
            
            let maxNumberOfTakers = object["MaxNumberOfTakers"] as? Int
            
            var numberOfTakers = 0
            let listOfTakers = object["ListTakers"] as? Array<PFUser>
            if(listOfTakers != nil){
                numberOfTakers = listOfTakers!.count
            }else{
        }
            
            cellView.cell_label_taskname.text = title
            cellView.cell_label_point.text = "\(point ?? 50)"
            cellView.cell_label_capacity.text = "\(numberOfTakers ?? 0)" + " / " + "\(maxNumberOfTakers ?? 0)"
        
            
        
        }
    
    
        return cellView
        
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.retrieveActivities()
        
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
                
                showUserActionMenu(title: "Çıkış Yap",message: "Çıkış yapmak istediğinizden emin misiniz?")
                //Here you can initiate your new ViewController

          }}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func retrieveActivities(){
        
        self.listTasks.removeAll()
        listTasksGlobal.removeAll()
       
    
        let query = PFQuery(className:"Activity")
//        query.whereKey("Type", equalTo: 1)
        query.whereKey("Type", notEqualTo: 5)
//        query.whereKey("Point", equalTo:75)
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
                    listTasksGlobal.append(object)
                    self.tableView.reloadData()
                    
                }
                
                self.tableView.reloadData()
                
                
            }
        }
        
   
         
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          


        if(self.listTasks.count > indexPath.row){
            let pfTask = self.listTasks[indexPath.row]
       
             let maxNumberOfTakers = pfTask["MaxNumberOfTakers"] as! Int
             let listTakers = pfTask["NumberOfTakers"] as? Array<PFUser>
             
             var numberOfTakers = 0
             if(listTakers != nil){
                    numberOfTakers = listTakers!.count
             }
        
        if(numberOfTakers < maxNumberOfTakers)
        {
            
            
            print("Tıklandı!")
            checkUserIsAlreadyRegistered(pfTask: self.listTasks[indexPath.row], indexPath: indexPath.row)

              
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
    
    
    
    func incrementRegisteredNumberOfAtendeesByOne(indexPath:Int){
        
            let pfTask = self.listTasks[indexPath]
//            var numberOfAtendees = pfTask["NumberOfTakers"] as! Int
//            numberOfAtendees += 1
//            print("NumberOfAtendees:"  + String!(numberOfAtendees))
//            pfTask["NumberOfTakers"] = numberOfAtendees
            
           
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
                self.performSegue(withIdentifier: "registeredSegue", sender: self)
                self.retrieveActivities()
                
            }
            
        }
            
        
    }
    
    func checkUserIsAlreadyRegistered(pfTask:PFObject,indexPath:Int){
        var canApply = true
        
        if(pfTask["ListTakers"] != nil){
        
        let pfCurrentUserId = PFUser.current()?.objectId
        var listTakers =  pfTask["ListTakers"] as? Array<PFUser>
    
       
        for user in listTakers! {
            
            if(user.objectId == pfCurrentUserId){
                
                showAlert(title: "Zaten Başvurdunuz.", message: "Katılmak istediğiniz etkinliğe zaten başvurdunuz.")
                canApply = false
                
            }
            
        }
        
        if(canApply){
            
            incrementRegisteredNumberOfAtendeesByOne(indexPath: indexPath)
            
        }
        
        

        
        
        }else{
            
             incrementRegisteredNumberOfAtendeesByOne(indexPath: indexPath)
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
               retrieveActivities()
        
        PPImageView.image = userProfileImageView
        PPImageView.setRounded()
        
           }

    

}

