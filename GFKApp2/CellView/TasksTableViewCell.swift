//
//  TasksTableViewCell.swift
//  GFKApp
//
//  Created by Deniz Can Ilgın on 26.02.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var cell_label_point: UILabel!
    @IBOutlet weak var cell_label_taskname: UILabel!
    @IBOutlet weak var cell_label_capacity: UILabel!
    
    
    @IBOutlet weak var ButtonAction: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
