//
//  CanvasView.swift
//  FingerPaint
//
//  Created by darkgod on 14/10/31.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    let zigzag = [(100,100),
        (100,150),(150,150),
        (150,200)]
    var currentColor: UIColor! = UIColor.blackColor() {
        didSet {
            if currentColor != oldValue {
                setNeedsDisplay()
            }
        }
    }
    
    var paths: [Path] = []
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        
        /*for (var i = 0; i < zigzag.count-1; i++) {
            drawLine(zigzag[i], end: zigzag[i+1], color: currentColor)
        }*/
        
        for path in paths {
            var points = path.points
            let cColor = path.color
            for (var i = 0; i < points.count-1; i++) {
                drawPath(points[i], end: points[i+1], color: cColor)
            }
            
        }
    }
    
    func drawPath(start: CGPoint, end: CGPoint, color: UIColor) {
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context, CGFloat(start.x), CGFloat(start.y))
        
        CGContextAddLineToPoint(context, CGFloat(end.x), CGFloat(end.y))
        
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        
        CGContextStrokePath(context)
    }
    
    func drawLine(start: (Int, Int), end: (Int, Int), color: UIColor) {
        // Get the drawing context.
        let context = UIGraphicsGetCurrentContext()
        
        // Create the shape (a vertical line) in the context.
        CGContextBeginPath(context)
        // Start to paint.
        CGContextMoveToPoint(context, CGFloat(start.0), CGFloat(start.1))
        
        // draw a line.
        CGContextAddLineToPoint(context, CGFloat(end.0), CGFloat(end.1))
        
        // Configure the drawing environment.
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        
        // Request the system to draw.
        CGContextStrokePath(context)
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // TODO: Start a new path, and add the starting touch point to it.
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        println("touch: \(point)")
        
        let path = Path(color: currentColor)
        path.add(point)
        paths.append(path)
        
        //setNeedsDisplay()
        
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // TODO: Add a new touch point to the path.
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        println("touch: \(point)")
        
        let path = paths.last
        path?.add(point)

        setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // TODO: Add the end touch point.
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        println("touch: \(point)")
        
        let path = paths.last
        path?.add(point)
        
        //setNeedsDisplay()
    }
    
    
    
}
