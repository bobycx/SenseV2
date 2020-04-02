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
    var currentView: CellView?
    var latestYCor: CGFloat = 0
    let spacing: CGFloat = 20
    var timesOffsetChanged: CGFloat = 0
    
    var snap : UISnapBehavior!
    var animator : UIDynamicAnimator!
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    lazy var normalViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    lazy var scrollview: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = normalViewSize
        //view.contentOffset = CGPoint(x:0, y:100)
        return view
    }()
    
    
    @objc func revealAnswer(sender: UIButton) {
        currentView!.frame.size.height = 70
        let str_result = String(Int(currentView!.firstLabel!.text!)! * Int(currentView!.secondLabel!.text!)!);
        currentView!.ansButton.setTitle(str_result, for: .normal);
        currentView!.ansButton.isEnabled = false
        // wait for user to dismiss: tap any open area
        print("hi")
        
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.currentView!.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height))))
            
        }, completion: { finished in
            self.latestYCor = CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height)))
            self.cellLevel += 1
            print(self.latestYCor)
            if self.cellLevel > (10-self.level) {
                self.enterNewLevel()
            }
            else {
                self.createNewView()
            }
        })
        
        
    }
    
    func createNewView() {
        if (Int(self.view.frame.height - latestYCor)) < 90 && timesOffsetChanged != 1 {
            let scrollPoint = CGPoint(x: 0.0, y: 300.0)
            scrollview.contentSize = contentViewSize
            scrollview.setContentOffset(scrollPoint, animated: false)
            timesOffsetChanged += 1
        }
        if let tempCellView = Bundle.main.loadNibNamed("CellView", owner: self, options: nil)?.first as? CellView {
            UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                self.scrollview.addSubview(tempCellView)
            }, completion: nil)
            tempCellView.tag = Int(String(level)+String(cellLevel))!
            cellViewInitialization(CellView: tempCellView, cl: String(cellLevel), ll: String(level))
            currentView = tempCellView
        }
    }
    
    func enterNewLevel() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //cellViewInitialization()
        //mainFlow(numOfViews: 5)
        view.addSubview(scrollview)
        createNewView()
        
        print("GL")
    }
    
    
    func cellViewInitialization(CellView: CellView,cl: String, ll: String) {
        print(timesOffsetChanged)
        //cellViewConstraints(CellView: CellView)
        CellView.cellView.backgroundColor = .clear
        CellView.center = CGPoint(x: self.view.frame.size.width  / 2, y: (self.view.frame.size.height / 2)*(timesOffsetChanged+1) - (timesOffsetChanged*spacing))
        
        /*
        if cellLevel != 1 {
            let aboveViewTag = Int(String(level)+String(Int(cellLevel)-1))
            let aboveView = self.view.viewWithTag(aboveViewTag!) as? CellView
            CellView.translatesAutoresizingMaskIntoConstraints = false
            CellView.topAnchor.constraint(equalTo: aboveView!.bottomAnchor, constant: 20).isActive = true
        }
        */
        CellView.ansButton.addTarget(self, action: #selector(GuidedLearningVC.revealAnswer(sender:)), for: .touchUpInside)
        CellView.layer.cornerRadius = 30
        CellView.backgroundColor = UIColor(gradientStyle:UIGradientStyle.leftToRight, withFrame:CellView.frame, andColors:[.flatPowderBlue, .flatPowderBlueDark])
        
        
        CellView.layer.shadowColor = UIColor.flatPowderBlueDark.cgColor
        CellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        CellView.layer.shadowOpacity = 0.7
        CellView.layer.shadowRadius = 4.0
        //firstNum.text = "1"
        //secondNum.text = "1"
        CellView.firstLabel.text = ll
        CellView.secondLabel.text = cl
        
        CellView.ansButton.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        CellView.ansButton.layer.cornerRadius = 20
        
        cellViewConstraints(CellView: CellView)
        
    }
    

    func cellViewConstraints(CellView: CellView) {
        CellView.translatesAutoresizingMaskIntoConstraints = false
        
        //CellView.cellView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //CellView.cellView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //CellView.cellView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        CellView.frame.size.height = self.view.frame.height
        CellView.center = CGPoint(x: self.view.frame.size.width  / 2, y: (self.view.frame.size.height / 2)*(timesOffsetChanged+1) - (timesOffsetChanged*spacing))
        print(CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(self.view.frame.height/2)))
        //CellView.cellView.frame.size.height = self.view.frame.height / 2
        CellView.cellView.center = CGPoint(x: CellView.cellView.frame.size.width  / 2, y: (self.view.frame.size.height / 2)*(timesOffsetChanged+1) - (timesOffsetChanged*spacing))
        print(CellView.center)
        //CellView.cellView.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(self.view.frame.height/2))
        print(CellView.cellView.center)
        
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


