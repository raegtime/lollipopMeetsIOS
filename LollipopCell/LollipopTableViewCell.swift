//
//  LolliPopTableViewCell.swift
//  LollipopCell
//
//  Created by Maurice Raguse on 06.05.15.
//  Copyright (c) 2015 Maurice Raguse. All rights reserved.
//

import UIKit

class LollipopTableViewCell: UITableViewCell {

    private var lastTouch : UITouch?
    var animationDuration : CFTimeInterval = 0.5 // "animate over 0.5 seconds or so.."
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if selectedBackgroundView == nil
        {
            return
        }
        
        if let firstTouch = touches.first as? UITouch
        {
            lastTouch = firstTouch
        }
        
        super.touchesBegan(touches, withEvent: event)
        
        var radius : CGFloat = CGRectGetWidth(self.contentView.frame)>CGRectGetHeight(self.contentView.frame) ? CGRectGetWidth(self.contentView.frame):CGRectGetHeight(self.contentView.frame)
        
        var circle = CAShapeLayer()
        
        var bezier:UIBezierPath = UIBezierPath(roundedRect: CGRectMake(-radius, -radius, 2.0*radius, 2.0*radius), cornerRadius: radius)
        circle.path = bezier.CGPath
        
        var point : CGPoint = CGPointMake(CGRectGetMidX(selectedBackgroundView.frame), 0)
        
        if let t = lastTouch
        {
            point = CGPointMake(t.locationInView(selectedBackgroundView).x, t.locationInView(selectedBackgroundView).y)
        }
        
        circle.position = point
        circle.fillColor = UIColor.blackColor().CGColor
        
        selectedBackgroundView.layer.mask = circle
        
        
        var  drawAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        drawAnimation.duration = animationDuration
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        
        
        // Experiment with timing to get the appearence to look the way you want
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // Add the animation to the circle
        circle.addAnimation(drawAnimation, forKey:"drawCircleAnimation");
    }

}
