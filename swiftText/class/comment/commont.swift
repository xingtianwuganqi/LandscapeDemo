//
//  commont.swift
//  swiftText
//
//  Created by 景军 on 2018/1/2.
//  Copyright © 2018年 景军. All rights reserved.
//

import UIKit
//宏
let ScreenW = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
let ScreenH = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
func colorWithRGB(RGB:String) -> UIColor {
    var cString:String = RGB
    if (cString.hasPrefix("#")){
        cString = (cString as NSString).substring(from: 1)
    }
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    var r:CUnsignedInt = 0,g:CUnsignedInt = 0,b:CUnsignedInt = 0;
    
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
}



