//
//  TakenEventsTableViewCell.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 3.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

class TakenEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelTitle: UILabel!
    @IBOutlet weak var LabelPoint: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
