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

var i = 0

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
           i = i - 1
            
               } else {
    
            checked = true
            i = i + 1
//             print(checked)
               }
        
        
        
        if(i < 5){
        var imageName = "number" + String(i)
        var image:UIImage = UIImage(named:imageName)!
        SurveyCellButton.setImage(image, for: UIControl.State.selected)
        }
    }
    
}
