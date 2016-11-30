//
//  BaseNavigationController.swift
//  MyRoundDisk
//
//  Created by sqluo on 2016/11/22.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController ,UINavigationControllerDelegate{
    
    var popDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //代理
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //实现滑动返回功能
        //清空滑动返回手势的代理就能实现
        if viewController == self.viewControllers[0] {
            self.interactivePopGestureRecognizer!.delegate = self.popDelegate
        }else{
            self.interactivePopGestureRecognizer!.delegate = nil
        }
        
    }
    
    
}
