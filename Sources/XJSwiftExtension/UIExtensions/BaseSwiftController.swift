//
//  XJTools_Swift
//  Created by JingXueLong.
//  Copyright © 2018 JingXueLong. All rights reserved.
//

import UIKit

open class BaseSwiftController: UIViewController {
    
    /// 重写以是否添加导航条 default true
    open var needNavView: Bool {get{return true}}
    /// 重写此属性不需再重写需要导航条 default false
    open var needBackBtn: Bool {get{return false}}
    /// 重写此属性更改title default nil
    open var titleName: String? {get{return nil}}
    /// 导航条
    public private (set) lazy var navView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: k_XJScreenWide, height: k_XJNavAndStatusHeight))
    /// centerLable
    public private (set) lazy var titleLabel: UILabel = UILabel()
    /// 返回按钮
    public private (set) lazy var backBtn: UIButton = UIButton()
    /// 导航条bottom line  color defalut  #dddddd
    public private (set) lazy var lineView: UIView = UIView()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        if needNavView || needBackBtn {
            addNavView()
        }
    }
    
    
    ///override 返回按钮事件
    @objc open func back(){
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }else{
            dismiss(animated: true, completion: nil)
        }
    }

    
    //MARK: 私有方法
    private func addNavView() {
        view.addSubview(navView)
        navView.backgroundColor = .white
        let centY: CGFloat = k_XJNavHeight/2.0 + k_XJStatusBarHeight
        
        if needBackBtn {
            if #available(iOS 13.0, *) {
                backBtn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            }
            navView.addSubview(backBtn)
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
            backBtn.frame = .init(x: 0, y: k_XJStatusBarHeight, width: k_XJNavHeight, height: k_XJNavHeight)
        }
        
        titleLabel.text = titleName
        titleLabel.font = XJFontPingSC_Medium(18)
        titleLabel.textColor = .init(colorHex: "#111111")
        navView.addSubview(titleLabel)
        lineView.backgroundColor = .init(colorHex: "dddddd")
        navView.addSubview(lineView)
        titleLabel.bounds = .init(origin: .zero, size: .init(width: 230.XJWide, height: k_XJNavHeight))
        titleLabel.center = .init(x: k_XJScreenWide/2.0, y: k_XJStatusBarHeight + k_XJNavHeight/2.0)
        lineView.frame = .init(x: 0, y: k_XJNavAndStatusHeight-1, width: k_XJScreenWide, height: k_pixWide)
    }

}


extension BaseSwiftController{  //MARK:  通用扩展方法分类
    
    /// Class快速获取tableview 预估值均为0，滑条显示关闭，自适应conteninset 关闭
    /// - Parameter frame: frame
    /// - Parameter style: style
    public class func ClassGetNormalTableView(frame: CGRect, style: UITableView.Style = .plain ) -> UITableView {
        let tableView = UITableView(frame: frame, style: style)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }
    
    /// 快速获取tableview 预估值均为0，滑条显示关闭，自适应conteninset 关闭
    /// - Parameter frame: fram
    /// - Parameter style: style
    public func getNormalTableView(frame: CGRect, style: UITableView.Style = .plain ) -> UITableView {
        return BaseSwiftController.ClassGetNormalTableView(frame: frame, style: style)
    }
    
    

}


