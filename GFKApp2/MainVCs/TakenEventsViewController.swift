//
//  TakenEventsViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 2.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class TakenEventsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listTakenActivities = [PFObject]()
    var listApprovedActivities = [PFObject]()
    var tableView:UITableView? = nil
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellView = tableView.dequeueReusableCell(withIdentifier: "table_cell_taken_events",for: indexPath) as! TakenEventsTableViewCell
        
        let Activity = listTakenActivities[indexPath.row]
        
        let title = Activity["Title"] as? String
        let point = Activity["Point"] as? Int
        
        cellView.LabelPoint.text = String(point!)
        cellView.LabelTitle.text = title!
        
        cellView.LabelStatus.text = "Kayıt olundu"
        cellView.LabelStatus.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
    
        
        
               return cellView
    }
    
    
    let array = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
        return listTakenActivities.count
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveTakenEvents()


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView = tableView
        return 100
    }
    
    func retrieveTakenEvents(){
        
        listTakenActivities.removeAll()
        
        let pfCurrentUserId = PFUser.current()?.objectId
        let query = PFQuery(className:"Activity")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) takenActivities.")
                // Do something with the found objects
                for Activity in objects {
                    print(Activity.objectId as Any)
                    
                    let listTakers = Activity["ListTakers"] as? Array<PFUser>
//                    let listApprovedTakers = Activity["ApprovedListTakers"] as? Array<PFUser>
                
                    if (listTakers != nil) {
                    
                        for user in listTakers! {

                            if(user.objectId == pfCurrentUserId){

                                self.listTakenActivities.append(Activity)
                                self.tableView!.reloadData()
                                print(" TakenActs: \(self.listTakenActivities.count) ")

                            }

                        }
                    }
                    
                      self.tableView!.reloadData()

                }
            }
        }
        
    }
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentAct = listTakenActivities[indexPath.row]
        let title = currentAct["Title"] as? String
        
        showDeletionAlert(title: "Kaydınızı Silin", message: title! + " isimli kursa kaydınızı silmek istediğinizden emin misiniz? ",index: indexPath.row)
        
    }
    
    func showDeletionAlert(title:String,message:String,index:Int){
         
         let alert = UIAlertController(title: "" + title, message: "" + message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Sil", style: .default, handler: { action in
            let currentAct = self.listTakenActivities[index]
            self.deleteRegOnCurrentAct(actPf: currentAct)
         }))
         alert.addAction(UIAlertAction(title: "Tut", style: .default, handler: nil))
         self.present(alert, animated: true)
         
     }
    
    func deleteRegOnCurrentAct(actPf:PFObject){
        
        var listTakers = actPf["ListTakers"] as? Array<PFUser>
        var index = 0
       
        for user in listTakers!{
            print("index:" + String(index))
            if(user.objectId == PFUser.current()?.objectId){
             print("indexFound:" + String(index))
                listTakers!.remove(at: index)
                actPf["ListTakers"] = listTakers
                actPf.saveInBackground { (succeeded, error)  in
                    if (succeeded) {
                        // The object has been saved.
                        print("SuccessfullyDeletedReg")
                        self.retrieveTakenEvents()
                        
                    } else {
                        // There was a problem, check error.description
                    }
                
            }
            
        }
      
    
        index = index + 1
        }
        
    }
    

}
