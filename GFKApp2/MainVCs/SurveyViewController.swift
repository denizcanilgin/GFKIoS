//
//  SurveyViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 3.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Parse

class SurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CheckButtonsDelegate {
    
    var check = [Bool]()
    var listActivities = [PFObject]()
    var tableView:UITableView!
    
    @IBAction func ButtonSubmit(_ sender: UIButton) {
        saveResults()
        
    }
    
    func checkBoxTappedd(at index: IndexPath) {
      
        if(check[index[1]] == true){
            check[index[1]] = false
    }else{
            check[index[1]] = true
        }
        
        print("\(index[1])  :   \(check[index[1]])")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView = tableView
        self.tableView.isEditing = true
        return listActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cellView = tableView.dequeueReusableCell(withIdentifier: "table_cell_survey",for: indexPath) as! SurveyTableViewCell
        
       let currentAct =  listActivities[indexPath.row]
        
          check.append(false)
          cellView.delegate = self
          cellView.indexPath = indexPath
        
        let title = currentAct["Title"] as? String
        
        cellView.SurveyCellTitle.text = title
        
        if(title == "Eğitimler" || title == "Yarışmalar" || title ==  "Atölyeler"  || title == "Seminerler" ){
            
            cellView.SurveyCellTitle.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cellView.SurveyCellTitle.font = UIFont.boldSystemFont(ofSize: 19.0)
           
            cellView.SurveyCellButton.isHidden = true
            cellView.SurveyCellButton.layoutIfNeeded()
            
        }else{
            
            cellView.SurveyCellTitle.font = UIFont.systemFont(ofSize: 16.0)
            cellView.SurveyCellTitle.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cellView.SurveyCellButton.isHidden = false
            cellView.SurveyCellButton.layoutIfNeeded()
            
        }
        
        if(check[indexPath.row]){
            cellView.SurveyCellButton.isSelected = true
        }else{
            cellView.SurveyCellButton.isSelected = false
        }
        
        return cellView
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.listActivities[sourceIndexPath.row]
        listActivities.remove(at: sourceIndexPath.row)
        listActivities.insert(movedObject, at: destinationIndexPath.row)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.retrieveEdu()
     
    }
    
    
    func saveResults(){
        var i = 0
        var selectedActs = [String]()
        
        for activity in listActivities {
            
                let currentAct = listActivities[i]
                let titleAct = currentAct["Title"] as? String
                selectedActs.append(titleAct!)
                print("selected: \(selectedActs.count)")
                
            
            
            i = i+1
            
        }

        let selectionList = PFObject(className:"Survey")
        selectionList["Selections"] = selectedActs
        selectionList["userId"] = PFUser.current()?.objectId
        selectionList.saveInBackground { (succeeded, error)  in
            if (succeeded) {
                // The object has been saved.

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                             let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                             controller.modalPresentationStyle = .fullScreen
                             self.present(controller, animated: true, completion: nil)

            } else {
                // There was a problem, check error.description
            }
        }
        
    }
    
    func retrieveEdu(){
        
        let eduTitle = PFObject(className:"Activity")
        eduTitle["Title"] = "Eğitimler"
        self.listActivities.append(eduTitle)
        
        let query = PFQuery(className:"Activity")
        query.whereKey("Type", equalTo:1)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
               
                // Do something with the found objects
                for object in objects {
                    print(object.objectId as Any)
                    self.listActivities.append(object)
                }
                self.tableView.reloadData()
                self.retrieveWS()
            }
            self.tableView.reloadData()
        }
        
    }
    
    func retrieveWS(){
           
           let wsTitle = PFObject(className:"Activity")
           wsTitle["Title"] = "Atölyeler"
           self.listActivities.append(wsTitle)
           
           let query = PFQuery(className:"Activity")
           query.whereKey("Type", equalTo:2)
           query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
               if let error = error {
                   // Log details of the failure
                   print(error.localizedDescription)
               } else if let objects = objects {
                   // The find succeeded.
                  
                   // Do something with the found objects
                   for object in objects {
                       print(object.objectId as Any)
                       self.listActivities.append(object)
                   }
                   self.tableView.reloadData()
                 self.retrieveConf()
               }
               self.tableView.reloadData()
           }
           
       }
    
    func retrieveConf(){
              
              let confTitle = PFObject(className:"Activity")
              confTitle["Title"] = "Seminerler"
              self.listActivities.append(confTitle)
              
              let query = PFQuery(className:"Activity")
              query.whereKey("Type", equalTo:3)
              query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                  if let error = error {
                      // Log details of the failure
                      print(error.localizedDescription)
                  } else if let objects = objects {
                      // The find succeeded.
                     
                      // Do something with the found objects
                      for object in objects {
                          print(object.objectId as Any)
                          self.listActivities.append(object)
                      }
                      self.tableView.reloadData()
                    self.retrieveComp()
                  }
                  self.tableView.reloadData()
              }
              
          }
    
    func retrieveComp(){
                
                let compTitle = PFObject(className:"Activity")
                compTitle["Title"] = "Yarışmalar"
                self.listActivities.append(compTitle)
                
                let query = PFQuery(className:"Activity")
                query.whereKey("Type", equalTo:4)
                query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                    if let error = error {
                        // Log details of the failure
                        print(error.localizedDescription)
                    } else if let objects = objects {
                        // The find succeeded.
                       
                        // Do something with the found objects
                        for object in objects {
                            print(object.objectId as Any)
                            self.listActivities.append(object)
                        }
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                }
                
            }
    
 


}
