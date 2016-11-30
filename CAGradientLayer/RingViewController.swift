//
//  RingViewController.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class RingViewController: BaseViewController {

    
    var ringView: RingView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let width: CGFloat = 250
        let rect = CGRect(x: (self.view.frame.width - width) / 2, y: 100, width: width, height: width)
        
        let angle = Angle(start: CGFloat.degreesToRadians(-190), end: CGFloat.degreesToRadians(10))
        
        ringView = RingView(frame: rect, angle: angle, clockwise: true)
        
        self.view.addSubview(ringView!)
        
        
        let btn = UIButton(frame: CGRect(x: (self.view.frame.width - 80) / 2, y: width + 100 + 20, width: 80, height: 30))
        btn.setTitle("点一下", for: UIControlState())
        btn.backgroundColor = UIColor.red
        
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        
        btn.addTarget(self, action: #selector(self.btnAct(send:)), for: .touchUpInside)
        
        self.view.addSubview(btn)
        
        
    }

    
    var isMax = true
    func btnAct(send: UIButton){
        
        if isMax {
            ringView?.perCent = 30
            isMax = false
        }else {
            ringView?.perCent = 98
            isMax = true
        }
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
