//
//  ViewController.swift
//  Sense
//
//  Created by Bob Yuan on 2019/10/31.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//
//  Changed by Tim on Dec. 1st, 2019

import UIKit

class ViewController:UIViewController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var num1 : Int?
    var num2 : Int?
    
    @IBOutlet weak var dynamicScrollView: UIScrollView!
    
    
    let testArray = ["1","2","3","4","5","6","7","8","9"]
    
    var pageNumber : Int = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dynamicScroll();
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //To caculate the number of page of current table view
        self.pageNumber = Int(tableView.frame.minX/self.dynamicScrollView.frame.size.width) + 1;
        print("\n page#=\(pageNumber)")
        
        return (10 - pageNumber)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //To caculate the number of page of current table view
        self.pageNumber = Int(tableView.frame.minX/self.dynamicScrollView.frame.size.width) + 1;
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
    
    let N_VIEWS:Int = 9; //Total number of the table views in the scroll view
    func dynamicScroll()
    {
        // normal iphone width
        let tableW:CGFloat = self.dynamicScrollView.frame.size.width;
        let tableH:CGFloat = self.dynamicScrollView.frame.size.height;
        let tableY:CGFloat = 0;
        let totalCount:NSInteger = N_VIEWS;//# of table views；
        
        for i in 1...N_VIEWS
        {
            var tView: UITableView;
            tView = UITableView();
            // 9 x the normal width
            tView.frame = CGRect(x: CGFloat(i-1) * tableW, y: tableY, width: tableW, height: tableH);
            
            tView.delegate = self;
            tView.dataSource = self;
            tView.tableFooterView = UIView();
            tView.backgroundColor = UIColor.clear;
            tView.separatorStyle = .none;
            tView.allowsSelection = false;
            tView.rowHeight = UITableView.automaticDimension
            tView.estimatedRowHeight = 120.0
            tView.rowHeight = 80
            tView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionTVCell");
            
            dynamicScrollView.addSubview(tView);
        }
        
        let contentW:CGFloat = tableW * CGFloat(totalCount);//這個表示整個ScrollView的長度；
        dynamicScrollView.contentSize = CGSize(width: contentW, height: 0);
        dynamicScrollView.isPagingEnabled = true;
        dynamicScrollView.delegate = self;
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        //Just for testing....
        //Might be used later.
        //currentPage presents the number of current table view
        
        let currentPage:Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        print("scrollView Page: \(currentPage)");
        
        //if currentPage == 0 {
        //    self.scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width * CGFloat(numberOfItems), y: scrollView.contentOffset.y)
        //}
        //else if currentPage == numberOfItems {
        //    self.scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y)
        //}
    }
    
}

