//
//  BubbleCell.swift
//  Sense
//
//  Created by Tim on 2020/4/3.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import Foundation
import UIKit

class BubbleCellView: UIView {
    //消息内容视图
    var customView:UIView!
    //消息背景
    var bubbleImage:UIImageView!
    var avatarImage:UIImageView!
    
    //消息数据结构
    var msgItem:CellView!
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
  
    init(frame:CGRect, data:CellView?){
        super.init(frame: frame)
        //self.msgItem = data
        rebuildUserInterface()
    }
    
    func msgItem(data:CellView)
    {
        self.msgItem = data
    }
    
    
    func rebuildUserInterface() {
        
        //self.selectionStyle = UITableViewCell.SelectionStyle.none

        if (self.avatarImage == nil)
        {
            //显示用户头像
            self.avatarImage
                = UIImageView(image:UIImage(named:"xiaohua.png"))
            
        }
        
        let width:CGFloat =  400 //self.msgItem.frame.size.width
        let height:CGFloat = 30 //self.msgItem.frame.size.height
        
        var x:CGFloat =  0//self.msgItem.frame.minX
        var y:CGFloat =  70//self.msgItem.frame.maxY
        
        print("x=\(x) and y=\(y)")
        
        y = y + 630
        self.avatarImage.layer.cornerRadius = 9.0
        self.avatarImage.layer.masksToBounds = true
        self.avatarImage.layer.borderColor = UIColor(white:0.0 ,alpha:0.2).cgColor
        self.avatarImage.layer.borderWidth = 1.0
        
       
        //set the frame correctly
        self.avatarImage.frame = CGRect(x: x, y: y, width: 50, height: 50)
        self.addSubview(self.avatarImage)
        
        
        //self.customView = self.msgItem
        //self.customView.frame = CGRect(x: x + self.msgItem.bounds.minX,                       y: y + self.msgItem.bounds.minY, width: width, height: height)
        //self.addSubview(self.customView)
        
        if (self.bubbleImage == nil){
            
            self.bubbleImage = UIImageView(image:UIImage(named:("yoububble.png"))!.stretchableImage(withLeftCapWidth: 21,topCapHeight:14))
                
            
            
            print("x=\(x), y=\(y), width=\(width+25), height=\(height+50)")
            
            self.bubbleImage.frame = CGRect(x: x+10, y: y-100,
                                        width: width ,
                                        height: height + 70)
            
            self.addSubview(self.bubbleImage)
            
        }
        
    }
}
