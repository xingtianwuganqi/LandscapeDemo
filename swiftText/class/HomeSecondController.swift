//
//  HomeSecondController.swift
//  swiftText
//
//  Created by jingjun on 2018/7/11.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import SnapKit

class HomeSecondController: UIViewController {
    
    /*
     打开 General 中的 Device orientation 中的 landscapeLeft 与 landscapeRight
     appdelegate中 supportedInterfaceOrientationsFor 中 return .allButUpsideDown
 
    */
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let showView = UIView().then { (view) in
        view.backgroundColor = UIColor.white
    }
    
    let showLabel = UILabel().then { (label) in
        label.text = "Label位置"
        label.textColor = .black
        label.frame = CGRect(x: 0, y: 64, width: 80, height: 20)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        title = "second"
        
        
        view.addSubview(showView)
        view.addSubview(showLabel)
        setUI()
        
        //注册通知
        if !UIDevice.current.isGeneratingDeviceOrientationNotifications {
            //生成通知
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    func setUI() {
        showView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.blockRotation = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appDelegate.blockRotation = false
        
        //判断退出时是否是横屏
        if UIApplication.shared.statusBarOrientation.isLandscape {
            //是横屏让变回竖屏
            setNewOrientation(fullScreen: false)
        }
        
    }
    
    //横竖屏
    func setNewOrientation(fullScreen: Bool) {
        if fullScreen { //横屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            
        }else { //竖屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
    
    @objc private func handleDeviceOrientationChange(notification: Notification) {
        
        let orientation = UIDevice.current.orientation
        
        switch orientation {
            
        case .portrait:
            
            /* iOS8之后,横屏UIScreen.main.bounds.width等于竖屏时的UIScreen.main.bounds.height
            
             let ScreenW = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
             let ScreenH = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
             
            ScreenW 记录的是屏幕短边的长度
            ScreenH 记录的是屏幕长边的长度
            */
            showLabel.frame = CGRect(x: 0, y: 64, width: ScreenW, height: 20)

        case .landscapeLeft:
            showLabel.frame = CGRect(x: 0, y: 64, width: ScreenW, height: 20)

            
        case .landscapeRight:
            //横屏后做界面的调整的代码
            showLabel.frame = CGRect(x: 200, y: 200, width: 80, height: 20)

            
        default:
            
            break
            
            
        }
    }
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
