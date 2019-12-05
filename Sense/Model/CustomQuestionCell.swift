//
//  QuestionCell.swift
//  Sense
//
//  Created by Bob Yuan on 2019/11/19.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomQuestionCell: UITableViewCell {

    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var numberOne: UILabel!
    @IBOutlet weak var numberTwo: UILabel!
    @IBOutlet weak var questionButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //var colors : Dictionary<UIColor,UIColor> = [UIColor.flatYellow: UIColor.flatYellowDark, UIColor.flatPowderBlue: UIColor.flatPowderBlueDark]
        
        questionView.layer.cornerRadius = 30
        questionView.backgroundColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:questionView.frame, andColors:[.flatPowderBlue, .flatPowderBlueDark])
        
        
        questionView.layer.shadowColor = UIColor.flatPowderBlueDark.cgColor
        questionView.layer.shadowOffset = CGSize(width: 1, height: 1)
        questionView.layer.shadowOpacity = 0.7
        questionView.layer.shadowRadius = 4.0
        
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
            if let vc = self.superview?.parentViewController as? LearnViewController {      vc.speechMessage(message:str);
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
