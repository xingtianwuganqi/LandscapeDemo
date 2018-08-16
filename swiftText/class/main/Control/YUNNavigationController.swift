//
//  YUNNavigationController.swift
//  swiftText
//
//  Created by jingjun on 2018/7/11.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
import Then

class YUNNavigationController: UINavigationController,UIGestureRecognizerDelegate{
    
    
    fileprivate var gesture : UIScreenEdgePanGestureRecognizer?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.tintColor = .black
        self.navigationBar.barTintColor = .white
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-500, 0), for:UIBarMetrics.default)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let target = self.interactivePopGestureRecognizer?.delegate
        let handler = NSSelectorFromString("handleNavigationTransition:")
        
        self.gesture = UIScreenEdgePanGestureRecognizer(target: target, action: handler)
        self.gesture?.edges = UIRectEdge.left
        self.gesture?.delegate = self
        
        let view = self.interactivePopGestureRecognizer?.view
        view?.addGestureRecognizer(self.gesture!)
        
        self.interactivePopGestureRecognizer?.isEnabled = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    //是否支持多手势
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.topViewController != self.viewControllers.first
    }
    //是否允许手势触发
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.childViewControllers.count == 1 ? false : true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count != 0 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "backed"), style: .plain, target: self, action: #selector(backClick))
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc func backClick() {
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
