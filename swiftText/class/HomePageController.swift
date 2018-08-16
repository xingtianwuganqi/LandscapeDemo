//
//  HomePageController.swift
//  swiftText
//
//  Created by jingjun on 2018/7/11.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import RxSwift


class HomePageController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let second = HomeSecondController()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(second, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

