//
//  CommonConfigs.swift
//  iOS_BananaCP
//
//  Created by Stk on 2020/8/28.
//  Copyright © 2020 STK. All rights reserved.
//

import Foundation
import UIKit
// MARK: -界面常量
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height
var kIsiPhoneX: Bool {
    return ((kScreenWidth == 375.0 && kScreenHeight == 812.0) ||
            (kScreenWidth == 414.0 && kScreenHeight == 896.0) ||
            (kScreenWidth == 360.0 && kScreenHeight == 780.0) ||
            (kScreenWidth == 390.0 && kScreenHeight == 844.0) ||
            (kScreenWidth == 428.0 && kScreenHeight == 926.0))
}
var kStatusBarHeight: CGFloat {
    return kIsiPhoneX ? 44.0 : 20.0
}
var kNaviBarHeight: CGFloat {
    return kIsiPhoneX ? 88.0 : 64.0
}
var kTabBarHeight: CGFloat {
    return kIsiPhoneX ? (49.0 + 34.0) : 49.0
}
var kStatusBarSafeInsetHeight: CGFloat {
    return kIsiPhoneX ? 20.0: 0.0
}
var kTabBarSafeInsetHeight: CGFloat {
    return kIsiPhoneX ? 34.0 : 0.0
}
