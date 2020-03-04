//
//  BlogTableViewCell.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 29.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_label_title: UILabel!
    @IBOutlet weak var cell_imageview_post: UIImageView!
    @IBOutlet weak var cell_label_content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
