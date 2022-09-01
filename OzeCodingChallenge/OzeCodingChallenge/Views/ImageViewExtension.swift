//
//  ImageViewExtension.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import Foundation
import UIKit



extension UIImageView {

open func setTransactionImage(string: String?,
                            color: UIColor? = nil,
                            circular: Bool = false,
                            stroke: Bool = false,
                            textAttributes: [NSAttributedString.Key: Any]? = nil,
                            fontSize: CGFloat) {
    
    let image = imageSnap1(text: string != nil ? string?.initials.safelyLimitedTo(length: 1) : "",
                          color: color ?? .random,
                          circular: circular,
                          stroke: stroke,
                          textAttributes:textAttributes,
                          textSize: fontSize)
    
    if let newImage = image {
        self.image = newImage
    }
  }
    
    private func imageSnap1(text: String?,
                           color: UIColor,
                           circular: Bool,
                           stroke: Bool,
                           textAttributes: [NSAttributedString.Key: Any]?,
                           textSize: CGFloat) -> UIImage? {
        
        let scale = Float(UIScreen.main.scale)
        var size = bounds.size
        if contentMode == .scaleToFill || contentMode == .scaleAspectFill || contentMode == .scaleAspectFit || contentMode == .redraw {
            size.width = CGFloat(floorf((Float(size.width) * scale) / scale))
            size.height = CGFloat(floorf((Float(size.height) * scale) / scale))
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(scale))
        let context = UIGraphicsGetCurrentContext()
        if circular {
            let path = CGPath(ellipseIn: bounds, transform: nil)
            context?.addPath(path)
            context?.clip()
        }
        
        // Fill
        
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let attributes = textAttributes ?? [NSAttributedString.Key.foregroundColor: UIColor.white,
                                            NSAttributedString.Key.font: UIFont.semiBoldFont(ofSize: textSize)]
        
        
        //stroke color
        if stroke {
            
            //outer circle
            context?.setStrokeColor(WHITE_COLOR.cgColor)
            context?.setLineWidth(6)
            let rectangle : CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context?.addEllipse(in: rectangle)
            context?.drawPath(using: .fillStroke)
            
        }
        
        // Text
        if let text = text {
            let textSize = text.size(withAttributes: attributes)
            let bounds = self.bounds
            let rect = CGRect(x: bounds.size.width/2 - textSize.width/2, y: bounds.size.height/2 - textSize.height/2, width: textSize.width, height: textSize.height)
            
            text.draw(in: rect, withAttributes: attributes)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func rounded() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
    

}
