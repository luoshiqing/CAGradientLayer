//
//  RingView.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit


//MARK:弧度结构体
struct Angle {
    var start: CGFloat
    var end: CGFloat
}
//MARK: CGFloat延展
//度数转弧度
extension CGFloat {
    static func degreesToRadians(_ angle: CGFloat) -> CGFloat{
        return (CGFloat(M_PI) * angle) / 180.0
    }
}


class RingView: UIView {
    //始末位置
    fileprivate var angle: Angle!
    //画圆方向，true为顺时针，false为逆时针
    fileprivate var clockwise: Bool!
 
    //左右间距
    var toLeft: CGFloat = 10
    
    //弧形宽度
    var lineWidth: CGFloat = 3.0
    //圆心
    var myCenter: CGPoint!
    //半径
    var myRadius: CGFloat!
    
    //移动的渐变的进度条
    fileprivate var progressLayer: CAShapeLayer!
    
    
    
    //圆圈的直径
    var circW: CGFloat = 10
    var circView: UIView!
    
    
    
    init(frame: CGRect, angle: Angle, clockwise: Bool) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.groupTableViewBackground
        
        self.angle = angle
        self.clockwise = clockwise
        
        self.myCenter = CGPoint(x: frame.width / 2, y: frame.height / 2)
 
        //初始化圆的起始弧度
        self.circStartAngle = self.angle.start
    
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate var circStartAngle: CGFloat = 0
    
    
    //显示的分段的颜色
    var colors = [UIColor(red: 53/255.0, green: 212/255.0, blue: 223/255.0, alpha: 1).cgColor,
                  UIColor(red: 157/255.0, green: 237/255.0, blue: 127/255.0, alpha: 1).cgColor,
                  UIColor.yellow.cgColor,
                  UIColor.purple.cgColor]
    //修改perCent的值，可以获得对应的图形位置
    // 0 - 100的数值，对应比例 0-1
    var perCent: CGFloat = 0 {
        
        didSet{
            //渐变动画------->>>>
            CATransaction.begin()
            //是否添加动画，false为有动画
            CATransaction.setDisableActions(false)
            
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear))
        
            CATransaction.setAnimationDuration(0.5)
            
            self.progressLayer.strokeEnd = perCent / 100.0
            
            CATransaction.commit()
            
            //圆点视图动画-------->>>>>
            
            //计算弧度,中心点
            let (angle,center) = self.percentToCenter(percent: perCent / 100.0)
            //如果该次终点大于上次的起点，则顺时针动画，反之 逆时针动画
            var clock = true
            
            if angle > self.circStartAngle {
                clock = true
            }else{
                clock = false
            }
            
            let path = UIBezierPath(arcCenter: self.myCenter, radius: self.myRadius, startAngle: self.circStartAngle, endAngle: angle, clockwise: clock)
            
            let orbit = CAKeyframeAnimation(keyPath: "position")
            orbit.duration = 0.5
            orbit.path = path.cgPath
            orbit.calculationMode = kCAAnimationPaced
            orbit.repeatCount = 1
            
            self.circView.layer.add(orbit, forKey: "Move")
            //让圆视图停留在终点位置(否则会回到原来的位置)
            self.circView.layer.position = center
            
            
            //记录最后一次的终点，做为下次的起点
            self.circStartAngle = angle
        }
    }
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        //设置半径,默认为高度的一半
        if myRadius == nil {
            myRadius = (rect.height - self.lineWidth - self.toLeft * 2) / 2
        }
        
        //完成的进度轨迹
        let trackLayer = CAShapeLayer()
        trackLayer.frame = self.bounds
        
        self.layer.addSublayer(trackLayer)
        
        //内部填充颜色
        trackLayer.fillColor = UIColor.clear.cgColor
        //线条填充颜色
        trackLayer.strokeColor = UIColor.gray.cgColor
        
        trackLayer.opacity = 0.3
        
        trackLayer.lineCap = kCALineCapRound
        trackLayer.lineWidth = lineWidth
        
        
        let path = UIBezierPath(arcCenter: myCenter, radius: myRadius, startAngle: angle.start, endAngle: angle.end, clockwise: clockwise)
        
        trackLayer.path = path.cgPath
        
        
        
        //进度条
        progressLayer = CAShapeLayer()
        
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.blue.cgColor
        
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineWidth = lineWidth
        
        progressLayer.path = path.cgPath
        
        progressLayer.strokeEnd = 0
        
        
        //layer
        let gradientLayer = CALayer()
        let gradientLayer1 = CAGradientLayer()
        //设置区域
        gradientLayer1.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //设置颜色
        gradientLayer1.colors = colors
        //设置分段
        gradientLayer1.locations = [0.18,0.4,0.85,1]
        //设置渐变颜色方向
        gradientLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer1.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradientLayer.addSublayer(gradientLayer1)

        gradientLayer.mask = progressLayer
        self.layer.addSublayer(gradientLayer)
        

        //添加一个圆视图
        //先计算圆的中心点
        let circCent = self.getCent(angle.start)
        //创建视图
        circView = UIView(frame: CGRect(x: 0, y: 0, width: circW, height: circW))
        circView.center = circCent
        
        circView.backgroundColor = UIColor.red
//        circView.alpha = 0.3
        circView.layer.cornerRadius = circW / 2
        circView.layer.masksToBounds = true
        self.addSubview(circView)
        
 
        
        //模拟，给一个初始值，不需要可以注释掉
//        self.perCent = 0
        
    }

    //MARK:圆点视图->获取弧度
    func getCent(_ angle: CGFloat) -> CGPoint{
        
        let x = cos(angle) * myRadius + self.myCenter.x
        let y = sin(angle) * myRadius + self.myCenter.y
        
        let center = CGPoint(x: x, y: y)
        
        return center
    }
    //MARK:圆点视图->获取弧度跟中心点
    fileprivate func percentToCenter(percent: CGFloat) -> (CGFloat,CGPoint){
        
        //起点跟终点的弧度和
        let andAngle = abs(self.angle.start) + abs(self.angle.end)
        
        let angle = percent * andAngle - abs(self.angle.start)
        
        let center = self.getCent(angle)
        
        return (angle,center)
        
    }

}
