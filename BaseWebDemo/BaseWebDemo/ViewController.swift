//
//  ViewController.swift
//  BaseWebDemo
//
//  Created by Stk on 2021/1/14.
//

import UIKit

class ViewController: UIViewController {

    lazy var testButton: UIButton = {
        let testButton = UIButton.init(frame: CGRect.zero)
        testButton.setTitle("跳转一个网页", for: .normal)
        testButton.backgroundColor = .blue
        testButton.addTarget(self, action: #selector(gotoWeb(sender:)), for: .touchUpInside)
        return testButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(self.testButton)
    }
    
    override func viewDidLayoutSubviews() {
        self.testButton.bounds = CGRect(x: 0, y: 0, width: 200.0, height: 50.0)
        self.testButton.center = self.view.center
    }

    @objc func gotoWeb(sender: UIButton) {
        let vc = BaseWKWebVC.init()
        vc.urlStr = "https://www.baidu.com"
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

