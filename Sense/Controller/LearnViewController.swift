//
//  LearnViewController.swift
//  Sense
//
//  Created by Bob Yuan on 2019/10/31.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//
//  Changed by Tim on Dec. 1st, 2019

import UIKit

import AVFoundation
import MediaPlayer
import ChameleonFramework
import Hero

class LearnViewController:UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource, AVSpeechSynthesizerDelegate{
    
    //Define vars for voice eviroment
    let synth = AVSpeechSynthesizer(); //TTS对象
    let audioSession = AVAudioSession.sharedInstance(); //语音引擎
    var learningMode = "" 
    
    var num1 : Int?
    var num2 : Int?
    
    var guidedLearning : Bool?
    
    @IBOutlet weak var dynamicScrollView: UIScrollView!
    @IBOutlet weak var backToChooseButton: UIButton!
    

    let testArray = ["1","2","3","4","5","6","7","8","9"]
    
    var pageNumber : Int = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        backToChooseButton.layer.cornerRadius = 25

        //Init voice eviroment
        synth.delegate = self;
        
        dynamicScroll()
    }
    
    @IBAction func backToChoose(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToChoose" {
            let dest = segue.destination as! TabBarController
            dest.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .down), dismissing: .slide(direction: .down))
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //To caculate the number of page of current table view
        //self.pageNumber = Int(tableView.frame.minX/self.dynamicScrollView.frame.size.width) + 1;
        print("\n page#=\(pageNumber)")
        
        //tableView.reloadData()
        
        return (10 - self.dynamicScrollView.currentPage)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //To caculate the number of page of current table view
        //self.pageNumber = Int(tableView.frame.minX/self.dynamicScrollView.frame.size.width) + 1;
        print("\n page__#=\(pageNumber)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTVCell", for: indexPath) as! CustomQuestionCell
        //print(cell.frame.width)
        
        
        let numberTwoNumber = Int(testArray[indexPath.row])! + (pageNumber - 1)
        if numberTwoNumber < 10 {
            cell.numberOne.text = String(pageNumber)
            cell.numberTwo.text = String(numberTwoNumber)
        }
        
        
        
        return cell
    }
    
    var gtView = UITableView();
    
    let N_VIEWS:Int = 9; //Total number of the table views in the scroll view
    func dynamicScroll()
    {
        // normal iphone width
        let tableW:CGFloat = self.dynamicScrollView.frame.size.width;
        let tableH:CGFloat = self.dynamicScrollView.frame.size.height;
        let tableY:CGFloat = 0;
        let totalCount:NSInteger = N_VIEWS;//# of table views；
        
        
        
        var tView: UITableView;
        tView = UITableView();
        /*
        if( i == 1)
        {
            gtView = tView;
        }
        */
        // 9 x the normal width
        tView.frame = CGRect(x: CGFloat(0) * tableW, y: tableY, width: tableW, height: tableH);
            
        tView.delegate = self;
        tView.dataSource = self;
        tView.tableFooterView = UIView();
        tView.backgroundColor = UIColor.clear;
        tView.separatorStyle = .none;
        tView.allowsSelection = false;
        tView.rowHeight = UITableView.automaticDimension
        tView.estimatedRowHeight = 120.0
        tView.rowHeight = 85
        tView.backgroundColor = .clear
        tView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionTVCell");
            
        dynamicScrollView.addSubview(tView);
        
    
        let contentW:CGFloat = tableW * CGFloat(totalCount);//這個表示整個ScrollView的長度；
        dynamicScrollView.contentSize = CGSize(width: contentW, height: 0);
        dynamicScrollView.isPagingEnabled = true;
        dynamicScrollView.delegate = self;
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolled")
        print(scrollView.currentPage)
        //探测page是否变没变
        if pageNumber == scrollView.currentPage {
            pageNumber = scrollView.currentPage
        }
        else {
            pageNumber = scrollView.currentPage
            //("c")
            print("current page \(scrollView.currentPage)")
            print("changed")
            // 防止创建多余的tableviews
            if dynamicScrollView.subviews.count < scrollView.currentPage+2{
                print("is empty page")
                let tableW:CGFloat = self.dynamicScrollView.frame.size.width;
                let tableH:CGFloat = self.dynamicScrollView.frame.size.height;
                let tableY:CGFloat = 0;
                let totalCount:NSInteger = N_VIEWS;//# of table views；
                
                var tView: UITableView;
                tView = UITableView();
                /*
                 if( pageNumber == 1)
                 {
                 gtView = tView;
                 }
                 */
                // 9 x the normal width
                tView.frame = CGRect(x: CGFloat(scrollView.currentPage-1) * tableW, y: tableY, width: tableW, height: tableH);
                
                tView.delegate = self;
                tView.dataSource = self;
                tView.tableFooterView = UIView();
                tView.backgroundColor = UIColor.clear;
                tView.separatorStyle = .none;
                tView.allowsSelection = false;
                tView.rowHeight = UITableView.automaticDimension
                tView.estimatedRowHeight = 120.0
                tView.rowHeight = 85
                tView.backgroundColor = .clear
                tView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionTVCell");
                
                dynamicScrollView.addSubview(tView)
                print(scrollView.subviews)
                
                //let prevView = scrollView.subviews[scrollView.currentPage-2]
                //prevView.removeFromSuperview()
            }
            else {
                print("subviews: \(dynamicScrollView.subviews.count)")
                print("tableview already exists")
            }
            
            
        }
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        //Just for testing....
        //Might be used later.
        //currentPage presents the number of current table view
        
        //if pageNumber == scrollView        // Do something with your page update
        //print("scrollViewDidEndDecelerating: \(currentPage)")
        
        
        //print(pageNumber)
        //let currentPage:Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //print("scrollView Page: \(currentPage)");
        
        
        //if currentPage == 0 {
        //    self.scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width * CGFloat(numberOfItems), y: scrollView.contentOffset.y)
        //}
        //else if currentPage == numberOfItems {
        //    self.scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        //}
    }
    
    //To speak out a message
    //Please see https://www.cnblogs.com/qian-gu-ling/archive/2017/03/22/6600993.html
    func speechMessage(message:String){
        //First, stop the current speaking
        synth.stopSpeaking(at: AVSpeechBoundary.immediate);
        
        if !message.isEmpty {
            do {
                // 设置语音环境，保证能朗读出声音（特别是刚做过语音识别，这句话必加，不然没声音）
                try audioSession.setCategory(AVAudioSession.Category.ambient)
            }catch let error as NSError{
                print("!!!error.code!!!\n")
                print(error.code)
            }
            //需要转的文本
            let utterance = AVSpeechUtterance.init(string: message)
            //设置语言，这里是English
            utterance.voice = AVSpeechSynthesisVoice.init(language: "us_EN")
            //设置声音大小
            utterance.volume = 1.0
            //设置音频
            utterance.pitchMultiplier = 1.1
            //开始朗读
            synth.speak(utterance)
            
        }
    }
    //
    //

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 1,
            delay: 0.05 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
        
        //Just for a demo
        /*
        if (indexPath.row == 5){
            //Please see https://stackoverflow.com/questions/34438889/how-to-do-transforms-on-a-calayer
            
            //Please see https://my.oschina.net/ozawa4865/blog/714906

            let degrees = 90.0
            let radians = CGFloat(degrees * Double.pi / 180)
            
            // translate
            var transform = CATransform3DMakeTranslation(190,610, 0)
            
            // rotate 设置旋转
            transform = CATransform3DRotate(transform, radians, 0.0, 0.0, 1.0)
            
            // scale 设置大小缩放
            transform = CATransform3DScale(transform, 0.1, 0.1, 0.1)
            
            // apply the transforms
            cell.layer.transform = transform
        
            UIView.animate(withDuration: 2) { () -> Void in
                // 动画实现将cell的layer复原
                cell.layer.transform = CATransform3DIdentity
            }
            

        // 最后复原cell的frame
        cell.frame = CGRect(x: 0, y: cell.frame.origin.y, width: cell.frame.size.width, height: cell.frame.size.height);
            
        }
         */
    }
    //
    //
}

//get ViewController for current View
//Please see https://stackoverflow.com/questions/1372977/given-a-view-how-do-i-get-its-viewcontroller

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

extension UIScrollView {
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5 * self.frame.size.width))/self.frame.width)+1
    }
}
