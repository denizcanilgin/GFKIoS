//
//  PostViewController.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 1.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PostViewController: UIViewController {

    @IBOutlet weak var LabelTitle: UILabel!
    
    @IBOutlet weak var IndexLabel: UILabel!
    @IBOutlet weak var ImageViewImage: UIImageView!
    @IBOutlet weak var LabelContent: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let title = listPostsGlobal[postIndex]["Title"] as? String
                  let content = listPostsGlobal[postIndex]["Content"] as? String
                  let image_url = listPostsGlobal[postIndex]["ImageUrl"] as? String

        
       
        LabelContent.text = content
        print("conten:" + content!)
        LabelTitle.text = title
        ImageViewImage.image = listImageGlobal[postIndex]
        
    
    }
    


}
