//
//  SucessfullyRegisteredViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 2.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class SucessfullyRegisteredViewController: UIViewController {

    @IBOutlet weak var LabelSuccessMessage: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let pfTask = listTasksGlobal[listTasksGlobalIndex]
        let titleTask = pfTask["Title"] as! String
        
        LabelSuccessMessage.text = titleTask + " isimli kursa başarıyla kayıt oldunuz. Kurs ile ilgili detaylı bilgilendirileceksiniz."
        
    }
    


}
