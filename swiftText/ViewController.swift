//
//  ViewController.swift
//  swiftText
//
//  Created by 景军 on 2017/11/23.
//  Copyright © 2017年 景军. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var tabelview:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let table:UITableView = UITableView.init(frame: self.view.frame)
        table.delegate = self;
        table.dataSource = self;
        self.view.addSubview(table);
//        self.tabelview = UITableView.init(frame: self.view.frame);
//        self.tabelview?.delegate = self;
//        self.tabelview?.dataSource = self;
//        self.view.addSubview(self.tabelview!)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell:textCellTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell") as? textCellTableViewCell
        if (cell == nil){
            cell = textCellTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        cell?.label?.text = "你好"
    
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

