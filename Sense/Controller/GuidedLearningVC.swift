//
//  GuidedLearningVC.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit
import ChameleonFramework

class GuidedLearningVC: UIViewController {
    
    var level: Int = 1
    var cellLevel: Int = 1
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var firstNum: UILabel!
    @IBOutlet weak var secondNum: UILabel!
    @IBOutlet weak var ansButton: UIButton!
    
    @IBAction func revealAnswer(_ sender: UIButton) {
        let str_result = String(Int(firstNum!.text!)! * Int(secondNum!.text!)!);
        ansButton.setTitle(str_result, for: .normal);
        // wait for user to dismiss: tap any open area
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.cellView.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(20 + (self.cellView.frame.height)))
        })
        cellLevel += 1
        if cellLevel > (10-level) {
            enterNewLevel()
        }
        creatNewView(cl: cellLevel, ll: level)
    }
    
    func creatNewView(cl: Int, ll: Int) {
        
    }
    
    func enterNewLevel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellViewInitialization()
        //mainFlow(numOfViews: 5)
        print("GL")
    }
    
    func cellViewInitialization() {
        cellView.layer.cornerRadius = 30
        cellView.backgroundColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:cellView.frame, andColors:[.flatPowderBlue, .flatPowderBlueDark])
        
        
        cellView.layer.shadowColor = UIColor.flatPowderBlueDark.cgColor
        cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellView.layer.shadowOpacity = 0.7
        cellView.layer.shadowRadius = 4.0
        firstNum.text = "1"
        secondNum.text = "1"
    }
    
    func mainFlow(numOfViews: Int) {
        for i in 1...numOfViews {
            firstNum.text = String(level)
            secondNum.text = String(i)
            
        }
    }
    
    
}

/*
class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        
    }
    
    let contentView: UIView = {
        let view = UIView
    }
}

*/
