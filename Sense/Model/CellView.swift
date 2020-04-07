//
//  CellView.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

// !!!
// Recoding for:  set the file's owner to "CellView" and leave View as a UIView.
// By Tim on April 5th, 2020
// !!!
import UIKit


class CellView: UIView {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet var cellView: UIView!
    @IBOutlet weak var ansButton: UIButton!
    @IBOutlet weak var secondLabel: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadView()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellView.frame = self.bounds
    }
    
    // getXibName
    private func getXibName() -> String {
        let clzzName = NSStringFromClass(self.classForCoder)
        let nameArray = clzzName.components(separatedBy: ".")
        var xibName = nameArray[0]
        if nameArray.count == 2 {
            xibName = nameArray[1]
        }
        return xibName
    }
    
    // Loadview
    func loadView() {
        if self.cellView != nil {
            return
        }
        //print("loadViewing...")
        self.cellView = self.loadViewWithNibName(fileName: self.getXibName(), owner: self)
        
        self.cellView.frame = self.bounds // Important!!!
        
        self.cellView.backgroundColor = UIColor.clear
        self.addSubview(self.cellView)
    }
    // xib for creating the objects of the CellView
    private func loadViewWithNibName(fileName: String, owner: AnyObject) -> UIView {
        let nibs = Bundle.main.loadNibNamed(fileName, owner: owner, options: nil)
        return nibs?[0] as! UIView
    }
    
}
    

