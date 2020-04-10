//
//  ChooseLearningModeVC.swift
//  Sense
//
//  Created by Bob Yuan on 2020-03-18.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit

class ChooseLearningModeVC: UIViewController {
    
    let c1 = UIColor(hex: "463730")
    
    @IBOutlet weak var guidedButton: UIButton!
    @IBOutlet weak var freeButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    
    @IBAction func guidedPressed(_ sender: UIButton) {
    }
    
    @IBAction func freePressed(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePopupView()
        //popupView.hero.modifiers = [.translate(y:100)]
    }
    func configurePopupView() {
        popupView.layer.cornerRadius = 10
        guidedButton.layer.cornerRadius = 13
        freeButton.layer.cornerRadius = 13
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
                
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                self.init(red: r, green: g, blue: b, alpha: a)
                
            }
        }
        
        
        return nil
    }
}
