//
//  UIImage+Cropping.swift
//  myLogs
//
//  Created by Neil Hurley on 3/24/15.
//  Copyright (c) 2015 Neil Hurley. All rights reserved.
//

import UIKit

extension UIImage {
    func cropToCircleWithBorderColor (color: UIColor, lineWidth: CGFloat) -> UIImage {
    
        let imgRect = CGRect(origin: CGPointZero, size: self.size)
        
        UIGraphicsBeginImageContext(imgRect.size)
        var context = UIGraphicsGetCurrentContext()
        
        CGContextAddEllipseInRect(context, imgRect)
        CGContextClip(context)
        
        self.drawAtPoint(CGPointZero)
        
        CGContextAddEllipseInRect(context, imgRect)
        color.setStroke()
        CGContextSetLineWidth(context, lineWidth)
        CGContextStrokePath(context)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage
        
    }
}