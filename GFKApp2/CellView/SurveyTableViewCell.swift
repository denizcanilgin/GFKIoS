//
//  SurveyTableViewCell.swift
//  GFKApp2
//
//  Created by Deniz Can Ilgın on 3.03.2020.
//  Copyright © 2020 GFK Girişimcilik ve İnovasyon Sportif Gençlik Platformu. All rights reserved.
//

import UIKit

protocol CheckButtonsDelegate{
    func checkBoxTappedd(at index:IndexPath)
}

class SurveyTableViewCell: UITableViewCell {

    var delegate:CheckButtonsDelegate!
    
       var indexPath:IndexPath!
       @IBAction func checkBoxAction(_ sender: UIButton) {
           self.delegate?.checkBoxTappedd(at: indexPath)
       }
    
//    @IBOutlet weak var LabelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
    }

    @IBOutlet weak var SurveyCellTitle: UILabel!
    @IBOutlet weak var SurveyCellButton: UIButton!
    

    
    var checked = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func ButtonTabbed(_ sender: UIButton) {
    
    UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
        
        if sender.isSelected {
            checked = false
//             print(checked)
               } else {
    
            checked = true
//             print(checked)
               }
    
    }
    
}
