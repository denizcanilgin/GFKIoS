//
//  SuccessfullyRegistered2ViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 11.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class SuccessfullyRegistered2ViewController: UIViewController {

    
    @IBOutlet weak var LabelSuccessMessage: UILabel!
     
       override func viewDidLoad() {
           super.viewDidLoad()

           let pfTask = listTasksGlobal2[listTasksGlobalIndex]
           let titleTask = pfTask["Title"] as! String
           
           LabelSuccessMessage.text = titleTask + " başarıyla eklediniz. Katılımınıza dair bilet ve fotoğrafınızı sisteme yükleyiniz."
           
       }
       

}
