//
//  ListenViewController.swift
//  Sense
//
//  Created by Bob Yuan on 2020/1/2.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit
import DrawerView
import AVFoundation
var audioPlayer: AVAudioPlayer!


class ListenViewController: UIViewController {
    
    @IBOutlet var drawerView: DrawerView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var isPaused = true
    var level: Int = 1
    var cellLevel: Int = 1
    
    let customFont = UIFont(name: "DK Cool Crayon", size: UIFont.labelFontSize)
    
    @IBAction func onSlide(_ sender: UISlider) {
        slider.value = roundf(slider.value)
        level = Int(slider.value)
        cellLevel = level
        firstLabel.text = level.asWord
        secondLabel.text = cellLevel.asWord
        ansLabel.text = (level*cellLevel).asWord
    }
    
    
    @IBAction func playPressed(_ sender: UIButton) {
        if isPaused == true {
            playButton.setImage(UIImage(named: "Pause"), for: .normal)
            isPaused = false
            looper()
        }
        else {
            playButton.setImage(UIImage(named: "Play"), for: .normal)
            isPaused = true
        }
        
    }
    
    func looper() {
        
        if isPaused == false {
                        if cellLevel > 9 {
                            level += 1
                            cellLevel = level
                        }
                        if cellLevel > 9 {
                            print("done")
                            
                        }
                    firstLabel.text = level.asWord
                    secondLabel.text = cellLevel.asWord
                    ansLabel.text = (level*cellLevel).asWord
                        cellLevel += 1
                    UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                            self.firstLabel.frame = CGRect(x: self.firstLabel.frame.origin.x, y: self.firstLabel.frame.origin.y - 20, width: self.firstLabel.frame.width, height: self.firstLabel.frame.height)
                            
                        }) { (complete) in
                            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                                self.firstLabel.frame = CGRect(x: self.firstLabel.frame.origin.x, y: self.firstLabel.frame.origin.y + 20, width: self.firstLabel.frame.width, height: self.firstLabel.frame.height)
                                
                            })
                        }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                            self.secondLabel.frame = CGRect(x: self.secondLabel.frame.origin.x, y: self.secondLabel.frame.origin.y - 20, width: self.secondLabel.frame.width, height: self.secondLabel.frame.height)
                            
                        }) { (complete) in
                            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                                self.secondLabel.frame = CGRect(x: self.secondLabel.frame.origin.x, y: self.secondLabel.frame.origin.y + 20, width: self.secondLabel.frame.width, height: self.secondLabel.frame.height)
                                
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                
                                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                                    self.ansLabel.frame = CGRect(x: self.ansLabel.frame.origin.x, y: self.ansLabel.frame.origin.y - 20, width: self.ansLabel.frame.width, height: self.ansLabel.frame.height)
                                    
                                }) { (complete) in
                                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
                                        self.ansLabel.frame = CGRect(x: self.ansLabel.frame.origin.x, y: self.ansLabel.frame.origin.y + 20, width: self.ansLabel.frame.width, height: self.ansLabel.frame.height)
                                        
                                    })
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        self.looper()
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    
                
            
        }
               
                    

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        firstLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        secondLabel.font = UIFontMetrics.default.scaledFont(for: customFont!)
        firstLabel.adjustsFontForContentSizeCategory = true
        secondLabel.adjustsFontForContentSizeCategory = true
 */
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        drawerView.shadowOpacity = 0
        drawerView.borderColor = .clear
        drawerView.snapPositions = [.collapsed, .partiallyOpen]

        
        
         
    }
    override func viewDidAppear(_ animated: Bool) {
        if let url = Bundle.main.url(forResource: "Sense", withExtension: "mp3"){
            
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            
            if audioPlayer == nil {
                print("Error in calling AVAudioPlayer().")
            }
            
            print("play....")
            audioPlayer?.play()

        }
    }
    
}



extension UIView {
    
    func smooth(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}

public extension Int {
  public var asWord: String {
    let numberValue = NSNumber(value: self)
    var formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter.string(from: numberValue)!
  }
}
