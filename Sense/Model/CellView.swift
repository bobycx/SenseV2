//
//  CellView.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit

class CellView: UIView {

    @IBOutlet weak var ansButton: UIButton!
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    


    
    
    @IBOutlet weak var cellView: UIView!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  /*使用懒加载,这样XIB的初始化只有在addSubview(view)时才会触发, 而此时xib类肯定已经初始化完毕了*/
    lazy var view: UIView = {
        return Bundle.main.loadNibNamed("CellView", owner: self, options: nil)?.first as! UIView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        view.frame = bounds
        addSubview(view)
        print("cellView initialized!")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        view.frame = bounds
        addSubview(view)
        print("cellView? initialized!")
    }
}
    

