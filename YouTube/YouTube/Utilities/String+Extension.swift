//
//  String+Extension.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/18/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation


extension String {
    
    func longFormatDateString() -> String {
        
        if self.count < 10 {
            return self
        }
        
        let _index = self.index(self.startIndex, offsetBy: 10)
        let dateString = self[..<_index] 
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date2 = dateFormatter.date(from: String(dateString)) {
            dateFormatter.dateFormat = "MMM, dd yyyy"
            return dateFormatter.string(from: date2)
        }
        
        return self
    }
}
