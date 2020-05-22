//
//  XJExtensions.swift
//  XJSwiftFramework
//
//  Copyright © 2018 JingXueLong. All rights reserved.
//

import Foundation
import UIKit
import CommonCrypto

public extension Int {
    ///根据屏幕自适配值
    var XJWide: CGFloat {get{getValueChangeFunc()(CGFloat(self) * k_XJWideScale)}}
    
    ///根据屏幕适配值 + iPhone X系列额外增加值
    func XJWideIphoneXAdd(_ add: Int) -> CGFloat {
        getValueChangeFunc()(CGFloat(self + add) * k_XJWideScale)
    }
}


public extension Double {
    ///根据屏幕自适配值
    var XJWide: CGFloat {get{getValueChangeFunc()(CGFloat(self) * k_XJWideScale)}}
    
    ///根据屏幕适配值 + iPhone X系列额外增加值
    func XJWideIphoneXAdd(_ add: Double) -> CGFloat {
        getValueChangeFunc()(CGFloat(self + add) * k_XJWideScale)
    }
}


public extension String {
    
    /// 字符串MD5
    func md5String() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    /// String 获取字符串位置 ，返回NSRange
    /// - Parameter baseStr: 目标Str
    func rangeOfStringWithReturnNSRange(_ baseStr: String) -> NSRange {
        let nsString = NSString.init(string: self);
        return nsString.range(of: baseStr)
    }
    
    
    
}



public extension UIColor {
    
    /// 便捷构造器生成颜色
    /// - Parameter colorHex: "ff0022" 或者 "#ff0022"
    /// - Parameter alpha: 透明度 可选值 默认1.0
    convenience init(colorHex: String, alpha: CGFloat = 1.0) {
        if (colorHex.hasPrefix("#") && colorHex.count == 7) || (colorHex.count == 6){
            let newColor = colorHex.suffix(6)
            let scanner = Scanner(string: String(newColor))
            scanner.scanLocation = 0
            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)
            let r = (rgbValue & 0xff0000) >> 16
            let g = (rgbValue & 0xff00) >> 8
            let b = rgbValue & 0xff
            self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha
            )
        }else{
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
        }
    }
    
    /// 根据 完成度 实现两个颜色过渡效果，逐步将RGB变为目标值
    /// - Parameter startColorStr: 开始颜色 "FF0033"
    /// - Parameter endColor: 结束颜色 "DD2288"
    /// - Parameter finish: 0.0 - 1.0
    class func changeColorToColor(startColorStr: String, endColor: String, finish: CGFloat = 0.5) -> UIColor {
        let scannerBase = Scanner(string: String(startColorStr))
        scannerBase.scanLocation = 0
        var rgbValue: UInt64 = 0
        scannerBase.scanHexInt64(&rgbValue)
        
        let baseR = CGFloat((rgbValue & 0xff0000) >> 16)
        let baseG = CGFloat((rgbValue & 0xff00) >> 8)
        let baseB = CGFloat(rgbValue & 0xff)

        let scannerChange = Scanner(string: String(endColor))
        scannerChange.scanLocation = 0
        scannerChange.scanHexInt64(&rgbValue)
        let endR = CGFloat((rgbValue & 0xff0000) >> 16)
        let endG = CGFloat((rgbValue & 0xff00) >> 8)
        let endB = CGFloat(rgbValue & 0xff)
        
        let changeR = baseR - endR
        let changeG = baseG - endG
        let changeB = baseB - endB
        
        let finishR = baseR - changeR * finish
        let finishG = baseG - changeG * finish
        let finishB = baseB - changeB * finish
        
        return UIColor.init(red: CGFloat(finishR/255.0), green: CGFloat(finishG/255.0), blue: CGFloat(finishB/0xff), alpha: 1.0)
    }
    
    /// 随机颜色
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

public extension UIImage{
    
    /// 根据颜色生成图片 可能为空
    /// - Parameter color: 目标颜色
    class func imageFormColor(_ color: UIColor) -> UIImage?{
        let size = CGSize(width: 1, height: 1)
        let rect: CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
}







public extension NSMutableAttributedString {
    convenience  init(string: String, font: UIFont, foregroundColor: UIColor, paragraph: NSParagraphStyle) {
        self.init(string: string)
        setAttributes([NSAttributedString.Key.font : font,
                       NSAttributedString.Key.paragraphStyle : paragraph,
                       NSAttributedString.Key.foregroundColor : foregroundColor], range: NSRange.init(location: 0, length: string.count))
    }
}

