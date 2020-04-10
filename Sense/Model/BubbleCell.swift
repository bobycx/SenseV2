//
//  BubbleCell.swift
//  Sense
//
//  Created by Tim on 2020/4/3.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import Foundation
import UIKit

class BubbleCell: UIView {
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
    
    //- (void) setupInternalData
    init(data:CellView){
        self.msgItem = data
        rebuildUserInterface()
    }

    func rebuildUserInterface() {
        
        //self.selectionStyle = UITableViewCell.SelectionStyle.none
        if (self.bubbleImage == nil)
        {
            self.bubbleImage = UIImageView()
            self.addSubview(self.bubbleImage)
        }
        if (self.avatarImage == nil)
        {
            //显示用户头像
            self.avatarImage
                = UIImageView(image:UIImage(named:"xiaohua.png"))
            
        }
 
     
        let width =  self.msgItem.frame.size.width
        let height = self.msgItem.frame.size.height
        
        var x:CGFloat =  0
        var y:CGFloat =  0
        
        self.avatarImage.layer.cornerRadius = 9.0
        self.avatarImage.layer.masksToBounds = true
        self.avatarImage.layer.borderColor = UIColor(white:0.0 ,alpha:0.2).cgColor
        self.avatarImage.layer.borderWidth = 1.0
            
        //别人头像，在左边，我的头像在右边
        let avatarX:CGFloat =  2
            
        //头像居于消息底部
        let avatarY:CGFloat =  height
        
        //set the frame correctly
        self.avatarImage.frame = CGRect(x: avatarX, y: avatarY, width: 50, height: 50)
        self.addSubview(self.avatarImage)
            
        //y = delta
        x += 54
        y += 1 //???
       
        self.customView = self.msgItem
        
        
        self.customView.frame = CGRect(x: x + self.msgItem.bounds.minX,
                                       y: y + self.msgItem.bounds.minY,
                                       width: width, height: height)
        
        self.addSubview(self.customView)
        
        //如果是别人的消息，在左边，如果是我输入的消息，在右边

        self.bubbleImage.image = UIImage(named:("yoububble.png"))!
                .stretchableImage(withLeftCapWidth: 21,topCapHeight:14)
            
        self.bubbleImage.frame = CGRect(x: x, y: y,
                                        width: width + 1 + 1,
                                        height: height + 1 + 1)
    }
}


