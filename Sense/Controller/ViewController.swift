//
//  ViewController.swift
//  Sense
//
//  Created by Bob Yuan on 2019/10/31.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var num1 : Int?
    var num2 : Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    let testArray = ["1","2","3","4","5","6","7","8","9"]
    
    var pageNumber : Int = 1
    
    override func viewDidLoad() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextTable))
        swipe.direction = .left
        view.addGestureRecognizer(swipe)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionTVCell")
        configureTableView()
    
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (10 - pageNumber)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTVCell", for: indexPath) as! CustomQuestionCell
        //print(cell.frame.width)
        
        
        let numberTwoNumber = Int(testArray[indexPath.row])! + (pageNumber - 1)
        if numberTwoNumber < 10 {
            cell.numberOne.text = String(pageNumber)
            cell.numberTwo.text = String(numberTwoNumber)
        }
        
        return cell
    }
    
    func configureTableView() {
        print(tableView.rowHeight)
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.allowsSelection = false
        
    }
    
    @objc func nextTable() {
        let originalTop = self.tableView.contentInset.top
        let originalBottom = self.tableView.contentInset.bottom
        let originalLeft = self.tableView.contentInset.left
        let originalRight = self.tableView.contentInset.right
        let newLeft = originalLeft - self.tableView.bounds.width/2 - 200
        let newRight = originalRight - self.tableView.bounds.width/2 - 200
        UIView.animate(withDuration: 1.0, animations: {
            self.tableView.contentInset = UIEdgeInsets(top: originalTop, left: newLeft, bottom: originalBottom, right: newRight)
        
            
        })
        
        sleep(1)
        
        self.pageNumber += 1
        self.tableView.reloadData()
        self.tableView.contentInset = UIEdgeInsets(top: originalTop, left: originalLeft, bottom: originalBottom, right: originalRight)
    }
}

