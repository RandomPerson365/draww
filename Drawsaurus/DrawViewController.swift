//
//  DrawViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-08-19.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    var brush: CGFloat = 5.0
    var lastPoint: CGPoint!
    var opacity: CGFloat = 1.0
    var desc: String = ""
    
    var mouseSwiped = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        red = 0.0
        green = 0.0
        blue = 0.0
      //  descLabel.text = desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("SegueDrawToMain", sender: self)
    }
    
    @IBAction func colorButtonSelected(sender: UIButton) {
        switch sender.tag {
        case 0:
            red = 0.0/255.0
            green = 0.0/255.0
            blue = 0.0/255.0
        case 1:
            red = 255.0/255.0
            green = 0.0/255.0
            blue = 0.0/255.0
        case 2:
            red = 0.0/255.0
            green = 0.0/255.0
            blue = 255.0/255.0
        case 3:
            red = 0.0/255.0
            green = 255.0/255.0
            blue = 0.0/255.0
        default:
            red = 0.0/255.0
            green = 0.0/255.0
            blue = 0.0/255.0
        }
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        mouseSwiped = false
        if let currentTouch = touches.first as? UITouch {
            lastPoint = currentTouch.locationInView(self.canvas)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        mouseSwiped = true
        
        if let currentTouch = touches.first as? UITouch {
            
            var currentPoint = currentTouch.locationInView(self.canvas)
            
            UIGraphicsBeginImageContext(self.canvas.frame.size)
            
            self.canvas.image?.drawInRect(CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
            
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
            self.canvas.alpha = opacity
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let rect = CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)
        if !mouseSwiped {
            UIGraphicsBeginImageContext(self.canvas.frame.size)
            
            self.canvas.image?.drawInRect(rect)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }

}
