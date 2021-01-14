//
//  BaseProgressView.swift
//  iOS_BananaCP
//
//  Created by Stk on 2021/1/13.
//  Copyright © 2021 STK. All rights reserved.
//

import UIKit

class BaseProgressView: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.trackTintColor = .clear// 进度条背景色
        self.tintColor = .green// 进度条颜色
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(progress: Float) {
        if self.isHidden {
            self.isHidden = false
        }
        
        self.alpha = 1.0
        self.setProgress(progress, animated: progress > self.progress)
        if progress >= 1.0 {
            UIView.animate(withDuration: 0.25, delay: 0.5, options: [.curveEaseOut]) {
                self.alpha = 0.0
            } completion: { (finished: Bool) in
                self.setProgress(0.0, animated: false)
            }
        }
    }
    
    public func hide() {
        self.isHidden = true
    }
}
