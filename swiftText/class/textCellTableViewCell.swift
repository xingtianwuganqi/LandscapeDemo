//
//  textCellTableViewCell.swift
//  swiftText
//
//  Created by 景军 on 2017/11/26.
//  Copyright © 2017年 景军. All rights reserved.
//

import UIKit

class textCellTableViewCell: UITableViewCell {
    
    var label:UILabel?
    var rightLab:UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.label = UILabel.init(frame: CGRect.init(x: 20, y: 10, width: 60, height: 20))
        self.label?.textColor = UIColor.red
        self.label?.font = UIFont.systemFont(ofSize: 12)
        self.label?.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.label!)
        
        self.rightLab = UIButton.init(type: UIButtonType.custom)
        self.rightLab?.setTitle("按钮", for: UIControlState.normal)
        self.rightLab?.backgroundColor = UIColor.green
        self.rightLab?.frame = CGRect.init(x: 100, y: 10, width: 50, height: 20)
        self.rightLab?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(self.rightLab!)
        
        
    }
//    override func layoutSubviews() {
//        <#code#>
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
