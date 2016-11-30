//
//  FlyView.swift
//  CAGradientLayer
//
//  Created by sqluo on 2016/11/25.
//  Copyright © 2016年 sqluo. All rights reserved.
//

import UIKit

class FlyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let PI = M_PI
    
    func animateInView(view: UIView){
        
        let totalAnimationDuration: TimeInterval = 6
        
        let heartSize = view.frame.width
        
        let heartCenterX = view.center.x
        
        let viewHeight = view.frame.height
        
        
        
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        view.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            
            view.transform = CGAffineTransform(scaleX: 1, y: 1)
            view.alpha = 0.9
            
            
        }, completion: nil)
        
        
        let i: Int = Int(arc4random_uniform(2))
        let rotationDirection: Int = 1 - (2 * i)
        
        let rotationFraction = arc4random_uniform(10)
        
        UIView.animate(withDuration: totalAnimationDuration, animations: {
            view.transform = CGAffineTransform(rotationAngle: CGFloat(rotationDirection) * CGFloat(self.PI) / (16 + CGFloat(rotationFraction) * 0.2))
        }, completion: nil)
        
        
        
        let heartTravelPath = UIBezierPath()
        heartTravelPath.move(to: view.center)
        
        let x: CGFloat = heartCenterX + CGFloat(rotationDirection) * CGFloat(arc4random_uniform(2 * UInt32(heartSize)))
        
        let y: CGFloat = viewHeight / 6.0 + CGFloat(arc4random_uniform(UInt32(viewHeight / 4.0)))
        
        let endPoint = CGPoint(x: x, y: y)
        
        //
        let j: Int = Int(arc4random_uniform(2))
        let travelDirection = 1 - (2 * j)
        
        //
        let xDelta: CGFloat = (heartSize / 2.0 + CGFloat(arc4random_uniform(2 * UInt32(heartSize)))) * CGFloat(travelDirection)
        
        let yDelta = max(endPoint.y, CGFloat(arc4random_uniform(UInt32(8 * heartSize))), heartSize)
        
        let controlPoint1 = CGPoint(x: heartCenterX + xDelta, y: viewHeight - yDelta)
        let controlPoint2 = CGPoint(x: heartCenterX - 2 * xDelta, y: yDelta)
        
        
        heartTravelPath.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        
        
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnimation.path = heartTravelPath.cgPath
        keyFrameAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        keyFrameAnimation.duration = totalAnimationDuration + Double(endPoint.y / viewHeight)
        view.layer.add(keyFrameAnimation, forKey: "positionOnPath")
        
        
        
        UIView.animate(withDuration: totalAnimationDuration, animations: {
            view.alpha = 0
        }) { (finished) in
            view.removeFromSuperview()
        }
        
        
    }
    
    

}
