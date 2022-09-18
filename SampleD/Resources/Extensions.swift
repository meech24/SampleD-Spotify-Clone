//
//  Extensions.swift
//  SampleD
//
//  Created by Demetrice Sims on 6/17/21.
//  Copyright © 2021 Demetrice Sims. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    var width: CGFloat{
        return frame.size.width
    }
    var height: CGFloat{
       return frame.size.height
   }
    var left: CGFloat{
        return frame.origin.x
   }
    var right: CGFloat{
       return left + width
   }
    var top: CGFloat{
        return frame.origin.y
   }
    var bottom: CGFloat{
           return top + height 
       }
}
extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()

static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
