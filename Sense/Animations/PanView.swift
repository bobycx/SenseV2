//
//  PanView.swift
//  Sense
//
//  Created by Bob Yuan on 2020-06-19.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit

enum slideStates {
    case top
    case bottom
}

class PanView: UIView {
    
    var  panViewStates: slideStates = .bottom  //默认状态是在底部
    var upPointY = 0.0   //最高值
    var middleY = 0.0  //滑动view 中间判定值
    var bottionY = 0.0  //最低值
    var currentY = 0.0   //当前的Y值
    
    let maxtop = 80.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countY()
        addPanRecoginer()
        addTapRecoginer()
    }
}


//计算数据值
extension PanView {
    func countY(){
        upPointY = maxtop   //最高值
        middleY = Double(((self.superview?.frame.height)! - CGFloat(maxtop))/2)  //滑动view 中间判定值
        bottionY = Double(self.frame.minY)  //最低值
        currentY = bottionY
    }
    
}

//手势
extension PanView {
    
    func addPanRecoginer(){
        let panRecoginer = UIPanGestureRecognizer.init(target: self, action: #selector(panHandle(pan:)))
        self.addGestureRecognizer(panRecoginer)
    }
    
    func addTapRecoginer(){
        let tapRecoginer = UITapGestureRecognizer.init(target: self, action: #selector(tapHandle(tap:)))
        self.addGestureRecognizer(tapRecoginer)
    }
    
}

//事件
extension PanView {
    
    @objc func panHandle(pan:UIPanGestureRecognizer){
        let  translation = pan.translation(in: self.superview)
        let  transY = Double(translation.y)
        
        if pan.state == .changed {
            
            print("pan.state = .changed")
            
            if Double(self.frame.origin.y) < upPointY{
                currentY = upPointY
            }else if Double(self.frame.origin.y) > bottionY{
                currentY = bottionY
            }else{
                self.frame.origin.y = CGFloat(currentY + transY)
            }
            
            
        }else if pan.state == .ended {
            
            print("pan.state = .ended")
            
            if (currentY + transY > upPointY) && (currentY + transY < middleY) { //如果当前位置在最上部和中线中间
                currentY = upPointY
            }else if (currentY + transY < bottionY) && (currentY + transY > middleY){
                currentY = bottionY
            }else if currentY + transY < upPointY{
                currentY = upPointY
            }else{
                currentY = bottionY
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: [], animations: {
                self.frame.origin.y = CGFloat(self.currentY)
            }) { (complete) in
                
            }
            
            currentY = Double(self.frame.origin.y)
        }
        
        
    }
    
    @objc func tapHandle(tap:UITapGestureRecognizer){
        
        print("tapped.")
    }
}
