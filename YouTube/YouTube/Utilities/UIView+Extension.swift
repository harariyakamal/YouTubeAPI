//
//  UIView+Extension.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/16/18.
//  Copyright © 2018 company. All rights reserved.
//

import UIKit


extension UIView {
    func addConstraintsWithFormat(_ format: String, _ views: UIView...) {
        
        var viewsDictionary: Dictionary<String, UIView> = [:]
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

