//
//  SomeView.swift
//  
//  XJToolswift
//  Created by JingXueLong.
//  Copyright © 2018 JingXueLong. All rights reserved.
//

import Foundation
import UIKit

/// 设置是适配值模式  default floor 小数向下取整 32.11 = 32.0   none 不取整  ceil 向上取整
public enum XJValuesMode {
    case ceil
    case floor
    case none
}


public var currentValuesMode: XJValuesMode = .floor

//常量

/// 屏幕宽度
public let k_XJScreenWide: CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度
public let k_XJScreenHeight: CGFloat = UIScreen.main.bounds.size.height
/// 状态栏高度
public let k_XJStatusBarHeight: CGFloat = is_XJIphoneWithSafeArea ? 44.0 : 20.0
/// 导航条高度
public let k_XJNavHeight: CGFloat = 44.0
/// 导航条加状态栏高度
public let k_XJNavAndStatusHeight: CGFloat = k_XJStatusBarHeight + k_XJNavHeight
/// Tabbar高度
public let k_XJTabbarHeight: CGFloat = 49.0
/// 底部仅安全区高度
public let k_XJBottomSafeAreaHeight: CGFloat = is_XJIphoneWithSafeArea ? 34.0:0.0
/// Tabbar高度和安全区
public let k_XJTabbarAndSafeAreaHeight: CGFloat = k_XJTabbarHeight + k_XJBottomSafeAreaHeight
/// 单像素高度
public let k_pixWide: CGFloat = (1.0/UIScreen.main.scale)
/// 屏幕比例系数
public let k_XJWideScale: CGFloat = UIScreen.main.bounds.width/375.0


//bool判断


/// 是否是手机
public var  is_XJIphone: Bool {get{
    return UIDevice.current.userInterfaceIdiom == .phone}
}

/// 是否是全屏手机
public let  is_XJIphoneWithSafeArea: Bool = getIs_XJIphoneWithSafeArea()


///适配值  Replace by  20.XJWide or 50.XJWideIphoneXAdd(10)
public func XJAutoWideValue(_ value: CGFloat, iphoneXAdd: CGFloat = 0) -> CGFloat {
    let needAdd: CGFloat = is_XJIphoneWithSafeArea ? CGFloat(iphoneXAdd) * k_XJWideScale : 0.0
    return getValueChangeFunc()(CGFloat(value) * k_XJWideScale + needAdd)
}
///适配值  Replace by  20.XJWide or 50.XJWideIphoneXAdd(10)
public func XJAutoWideValue(_ value: Int, iphoneXAdd: Int = 0) -> CGFloat {
    let needAdd: CGFloat = is_XJIphoneWithSafeArea ? CGFloat(iphoneXAdd) * k_XJWideScale : 0.0
    return getValueChangeFunc()(CGFloat(value) * k_XJWideScale + needAdd)
}
///适配值  Replace by  20.XJWide or 50.XJWideIphoneXAdd(10)
public func XJAutoWideValue(_ value: Double, iphoneXAdd: Double = 0) -> CGFloat {
    let needAdd: CGFloat = is_XJIphoneWithSafeArea ? CGFloat(iphoneXAdd) * k_XJWideScale : 0.0
    return getValueChangeFunc()(CGFloat(value) * k_XJWideScale + needAdd)
}

/**
    苹方-简 常规体
 　　font-family: PingFangSC-Regular, sans-serif;
*/
public func XJFontPingSC_Regular(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Regular", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}

/**
    苹方-简 中黑体
    font-family: PingFangSC-Medium, sans-serif;
*/
public func XJFontPingSC_Medium(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Medium", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}

/** 　　苹方-简 中粗体
　　font-family: PingFangSC-Semibold, sans-serif;
*/
public func XJFontPingSCemibold(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Semibold", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}
/**
    苹方-简 纤细体
    font-family: PingFangSC-Thin, sans-serif;
*/
public func XJFontPingSC_Thin(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Thin", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}
/**
    苹方-简 细体
    font-family: PingFangSC-Light, sans-serif;
*/
public func XJFontPingSC_Light(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Light", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}
/**
    苹方-简 极细体
    font-family: PingFangSC-Ultralight, sans-serif;
*/
public func XJFontPingSC_Ultralight(_ fontsize: Int) -> UIFont{
    UIFont(name: "PingFangSC-Ultralight", size: CGFloat(fontsize)) ?? UIFont.systemFont(ofSize: CGFloat(fontsize))
}


///执行一次
fileprivate func getIs_XJIphoneWithSafeArea() -> Bool{
    if is_XJIphone , #available(iOS 11.0,  * ){
        var bottom = 0.0
        if let window = UIApplication.shared.delegate?.window, let innerWindow = window {
            bottom = Double(innerWindow.safeAreaInsets.bottom)
        }else{
            let window = UIWindow(frame: UIScreen.main.bounds)
            bottom = Double(window.safeAreaInsets.bottom)
        }
        if bottom > 0.0  {
            return true
        }
    }
    return false
}


func getValueChangeFunc() -> (CGFloat) -> CGFloat {
    func nonefunc(value: CGFloat) -> CGFloat{
        return CGFloat(value)
    }
    func floorfunc(value: CGFloat) -> CGFloat{
        return CGFloat(floor(value))
    }
    func ceilfunc(value: CGFloat) -> CGFloat{
        return CGFloat(ceil(value))
    }
    switch currentValuesMode {
    case .none:
        return nonefunc(value:)
    case .ceil:
        return ceilfunc(value:)
    case .floor:
        return floorfunc(value:)
    }
    
}

