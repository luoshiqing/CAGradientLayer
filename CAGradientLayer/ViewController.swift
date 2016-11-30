//
//  ViewController.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class ViewController: BaseViewController ,CAAnimationDelegate{

    
    var gradientLayer: CAGradientLayer?
    
    var colorSets = [[CGColor]]()
    
    var currentColorSet: Int = 0
    
    var tap: UITapGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        //创建颜色 数组
        self.createColorSets()
        
        //添加一个手势
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)))
        self.view.addGestureRecognizer(tap!)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //创建layer
        self.createGradientLayer()
        
    }
    
    
    func handleTap(tap: UITapGestureRecognizer){
        //移除手势，防止多点
        self.view.removeGestureRecognizer(self.tap!)
        self.tap = nil
        /*
         首先我们需要确定下一个颜色集的下标是多少。如果使用的颜色集合是数组中的最后一个，我们需要重新计数下标（ currentColorSet = 0 ），如果不是上述情况，让 currentColorSet 自加一即可。
         */
        
        if self.currentColorSet < self.colorSets.count - 1 {
            
            self.currentColorSet += 1
            
        }else{
            self.currentColorSet = 0
        }
        
        //添加渐变动画
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        
        colorAnimation.delegate = self
        
        colorAnimation.duration = 2.0
        colorAnimation.toValue = self.colorSets[self.currentColorSet]
        colorAnimation.fillMode = kCAFillModeForwards
        
        colorAnimation.isRemovedOnCompletion = false
        
        self.gradientLayer?.add(colorAnimation, forKey: "colorChange")
        
 
    }
    
    
    
    
    
    //初始化gradientLayer并设置相关属性
    func createGradientLayer(){
        
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer?.frame = self.view.bounds
        
        self.gradientLayer?.colors = colorSets[currentColorSet]
        
        //方向
        self.gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
        self.gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        self.view.layer.addSublayer(gradientLayer!)
        
        
    }
    
    func createColorSets(){
        
        colorSets.append([UIColor.red.cgColor, UIColor.yellow.cgColor])
        colorSets.append([UIColor.green.cgColor, UIColor.cyan.cgColor])
        colorSets.append([UIColor.black.cgColor, UIColor.lightGray.cgColor])
        colorSets.append([UIColor.blue.cgColor, UIColor.magenta.cgColor])
  
        self.currentColorSet = 0
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            
            print("动画完成")
            gradientLayer?.colors = colorSets[self.currentColorSet]
            //添加手势
            self.tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(tap:)))
            self.view.addGestureRecognizer(tap!)
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

