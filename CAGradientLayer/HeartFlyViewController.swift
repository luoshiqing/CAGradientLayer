//
//  HeartFlyViewController.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class HeartFlyViewController: BaseViewController {

    
    enum MyColor {
        case one
        case tow
        case three
        case four
        case five
        case six
        case seven
        
        func color() -> UIColor{
            switch self {
            case .one:
                return UIColor.red
            case .tow:
                return UIColor.blue
            case .three:
                return UIColor.gray
            case .four:
                return UIColor.yellow
            case .five:
                return UIColor.green
            case .six:
                return UIColor.purple
            case .seven:
                return UIColor.black
            }
        }
        
        
        
        
    }
    
    
    var flyView: FlyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAct(tap:)))
        
        self.view.addGestureRecognizer(tap)
        
        flyView = FlyView(frame: CGRect(x: 0, y: self.view.frame.height - 400, width: self.view.frame.width, height: 400))
        flyView?.backgroundColor = UIColor.white
        self.view.addSubview(flyView!)

    }
    
    var array: [MyColor] = [MyColor.one,
                            MyColor.tow,
                            MyColor.three,
                            MyColor.four,
                            MyColor.five,
                            MyColor.six,
                            MyColor.seven]
    
    func tapAct(tap: UITapGestureRecognizer){
 
        
        let view = UIView(frame: CGRect(x: 40, y: self.flyView!.frame.height - 20 - 5, width: 20, height: 20))
        
        let arc: Int = Int(arc4random_uniform(UInt32(self.array.count)))
        
        let color1 = self.array[arc].color()
        
        view.backgroundColor = color1
        
        self.flyView?.addSubview(view)
        
        self.flyView?.animateInView(view: view)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}
