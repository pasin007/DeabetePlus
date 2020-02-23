//
//  Extension+UIColor.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit
extension UIColor  {
    public convenience init(_ hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)
    }

    public convenience init(hexInt: Int, alpha: Float = 1.0) {
        let hexString = String(format: "%06X", hexInt)
        self.init(hexString: hexString, alpha: alpha)
    }

    public convenience init(hexString: String, alpha: Float = 1.0) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var mAlpha: CGFloat = CGFloat(alpha)
        var minusLength = 0

        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
            minusLength = 1
        }
        if hexString.hasPrefix("0x") {
            scanner.scanLocation = 2
            minusLength = 2
        }
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        switch hexString.count - minusLength {
        case 3:
            red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            blue = CGFloat(hexValue & 0x00F) / 15.0
        case 4:
            red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
            green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
            blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
            mAlpha = CGFloat(hexValue & 0x00F) / 15.0
        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            mAlpha = CGFloat(hexValue & 0x000000FF) / 255.0
        default:
            break
        }
        self.init(red: red, green: green, blue: blue, alpha: mAlpha)
    }

    /// color components value between 0 to 255
    public convenience init(byteRed red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }

    public func alpha(_ value: Float) -> UIColor {
        let (red, green, blue, _) = colorComponents()
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(value))
    }

    public func red(_ value: Int) -> UIColor {
        let (_, green, blue, alpha) = colorComponents()
        return UIColor(red: CGFloat(value)/255.0, green: green, blue: blue, alpha: alpha)
    }

    public func green(_ value: Int) -> UIColor {
        let (red, _, blue, alpha) = colorComponents()
        return UIColor(red: red, green: CGFloat(value)/255.0, blue: blue, alpha: alpha)
    }

    public func blue(_ value: Int) -> UIColor {
        let (red, green, _, alpha) = colorComponents()
        return UIColor(red: red, green: green, blue: CGFloat(value)/255.0, alpha: alpha)
    }

    public func colorComponents() -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }

}

extension String {
    public var color: UIColor {
        return UIColor(hexString: self)
    }

}

extension Int {
    public var color: UIColor {
        return UIColor(hexInt: self)
    }

}

extension UIColor {
    public func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


