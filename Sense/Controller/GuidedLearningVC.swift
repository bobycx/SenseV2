//
//  GuidedLearningVC.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

// Main logic without changes, just for animation function
// By Tim on April 5th, 2020

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
        //Just for test
        view.frame.size.height = 300
        
        view.contentSize = normalViewSize
        //view.contentOffset = CGPoint(x:0, y:100)
        return view
    }()
    
    
    @objc func revealAnswer(sender: UIButton) {

        let str_result = String(Int(currentView!.firstLabel!.text!)! * Int(currentView!.secondLabel!.text!)!);

        currentView!.ansButton.setTitle(str_result, for: .normal);
        currentView!.ansButton.isEnabled = false

        // wait for user to dismiss: tap any open area
        print("hi")


        // Animating....
        UIView.animate(withDuration: 4, animations: {
            // Height
            self.currentView!.frame.size.height = 70
            // Center
            self.currentView!.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height))))
            
            if ( self.currentView!.center.y >= self.scrollview.frame.maxY){
                self.currentView!.center.y = self.scrollview.frame.maxY
            }
            // update layout right now if any changes
            self.view.layoutIfNeeded() // !!! important !!!
        }, completion: { finished in
            UIView.animate(withDuration: 4, animations: { () -> Void in
                //self.currentView!.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height))))
                UIView.performWithoutAnimation {
                    //self.currentView!.center.y = c_y //CGPoint(x: c_x, y: c_y )
                    
                }
                
            }, completion: { finished in
                
                self.latestYCor = CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height)))
                self.cellLevel += 1
                print(self.latestYCor)
                
                self.currentView!.center = CGPoint(x: CGFloat(self.view.frame.width/2), y: CGFloat(CGFloat(self.cellLevel)*(self.spacing + (self.currentView!.frame.height))))
                
                // CellView doesnot belong to scrollview at the beginning
                self.currentView!.removeFromSuperview()
                self.scrollview.addSubview(self.currentView!)
                
                
                if self.cellLevel > (10-self.level) {
                    self.enterNewLevel()
                    //source
                }
                else {
                    //temp commented
                    self.createNewView()
                }
            })
            
        })
  
    }
    
    func createNewView() {
        
        if (Int(self.view.frame.height - latestYCor)) < 90 && timesOffsetChanged != 1 {
            let scrollPoint = CGPoint(x: 0.0, y: 300.0)
            scrollview.contentSize = contentViewSize
            scrollview.setContentOffset(scrollPoint, animated: false)
            timesOffsetChanged += 1
        }
        //Just for test
        let tempCellView = CellView(frame: CGRect(x:0, y:0, width:300, height:self.view.frame.height-60))
        
        //let tempCellView = CellView(frame: CGRect(x:0, y:0, width:300, height:10))

        //let tempCellView = CellView(frame: self.view.bounds)
 
        UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                //self.scrollview.addSubview(tempCellView)
            }, completion: nil)
            
        tempCellView.tag = Int(String(level)+String(cellLevel))!
        
        cellViewInitialization(CellView: tempCellView, cl: String(cellLevel), ll: String(level))
        
        // !!!
        view.addSubview(tempCellView)
        
        currentView = tempCellView
        
        // update timely
        self.view.layoutIfNeeded()
        

    }
    
    func enterNewLevel() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollview)
        createNewView()
        
        print("GL")
    }
    
    
    func cellViewInitialization(CellView: CellView,cl: String, ll: String) {
        print(timesOffsetChanged)

        //CellView.cellView.backgroundColor = .clear
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
        
        // update timely
        self.view.layoutIfNeeded()

        //cellViewConstraints(CellView: CellView)
        
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


