//
//  UIColor+Extension.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/15/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var subLineColor = {
        return  UIColor(red: 155.0/255.0, green: 161.0/255.0, blue: 171.0/255.0, alpha: 1.0)
    }()
    
    static var lineColor = {
        return UIColor.black
    }()
    
    static var homeBackgroundViewColor = {
        return UIColor(white: 0.95, alpha: 1.0)
    }()
    
    static var seperatorColor = {
        return UIColor(red: 126.0/255.0, green: 128.0/255.0, blue: 132.0/255.0, alpha: 1.0)
    }()
    
    static var likeCommentLabelColor = {
        return UIColor(red: 155.0/255.0, green: 161.0/255.0, blue: 171.0/255.0, alpha: 1.0)
    }()
    
    static var bottomButtonColor = {
        return UIColor(red: 143.0/255.0, green: 150.0/255.0, blue: 163.0/255.0, alpha: 1.0)
    }()
    
    class var random: UIColor {
        let red = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let green = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let blue = CGFloat(arc4random()) / CGFloat(UInt32.max)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
