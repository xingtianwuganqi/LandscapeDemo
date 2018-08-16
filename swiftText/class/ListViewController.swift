//
//  ListViewController.swift
//  swiftText
//
//  Created by jingjun on 2018/7/11.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ListViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let button = UIButton(type: .custom).then { (btn) in
        btn.setTitle("横屏", for: .normal)
        btn.setTitle("竖屏", for: .selected)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "强制横屏"
        /*
         swift移除了NSInvocation, 只能桥接
         强制横屏时关闭 General 中的 Device orientation 中的 landscapeLeft 与 landscapeRight
         appdelegate中 supportedInterfaceOrientationsFor 中 return .landscapeRight

         */
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonClick(btn:)), for: .touchUpInside)
        setUI()
    }
    
    func setUI() {
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 30))
        }
    }
    
    @objc func buttonClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            appDelegate.blockRotation = true
            DeviceTool.interfaceOrientation(.landscapeLeft)

        }else{
            appDelegate.blockRotation = false
            DeviceTool.interfaceOrientation(.portrait)
        }
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
