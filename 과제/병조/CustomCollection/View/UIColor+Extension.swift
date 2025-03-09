//
//  UIColor+Extension.swift
//  CustomCollection
//
//  Created on 3/7/25.
//

import UIKit

extension UIColor {
    convenience init(_ color: Color) {
        self.init(
            red: CGFloat(color.red) / 255,
            green: CGFloat(color.green) / 255,
            blue: CGFloat(color.blue) / 255,
            alpha: 1
        )
    }
}
