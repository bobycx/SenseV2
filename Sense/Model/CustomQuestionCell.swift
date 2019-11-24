//
//  QuestionCell.swift
//  Sense
//
//  Created by Bob Yuan on 2019/11/19.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//

import UIKit

class CustomQuestionCell: UITableViewCell {

    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var numberOne: UILabel!
    @IBOutlet weak var numberTwo: UILabel!
    @IBOutlet weak var questionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        questionView.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func QuestionButtonPressed(_ sender: Any) {
        
        if questionButton.titleLabel?.text == "?" {
            questionButton.setTitle(String(Int(numberOne!.text!)! * Int(numberTwo!.text!)!), for: .normal)
            
            print("yay")
        }
        else {
            questionButton.setTitle("?", for: .normal)
        }
        
    }
    
}
