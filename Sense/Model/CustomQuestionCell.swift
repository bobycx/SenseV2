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
            
            let str_result = String(Int(numberOne!.text!)! * Int(numberTwo!.text!)!);
            questionButton.setTitle(str_result, for: .normal);
            let str = numberOne!.text! + " times " + numberTwo!.text! + " equals " + str_result;
            
            //Speak out str
            //get ViewController to get func speechMessage()
            if let vc = self.superview?.parentViewController as? ViewController {      vc.speechMessage(message:str);
            }
            else{
                print("error in customQuestionCell\n")
            }
            print("yay"); 
        }
        else {
            questionButton.setTitle("?", for: .normal)
        }
        
    }
}
