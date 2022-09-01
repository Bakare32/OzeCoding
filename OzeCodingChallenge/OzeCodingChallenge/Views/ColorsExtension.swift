//
//  ColorsExtension.swift
//  OzeCodingChallenge
//
//  Created by Bakare Waris on 31/08/2022.
//

import UIKit

extension UIColor {
    
    class func getRandomColor() -> UIColor {
        let colors = [PINKISH, BROWNISH, ORANGISH, LIME, PURPLISH, BLUISH, GREENISH]
        //let randomNumber = arc4random_uniform(UInt32(colors.count))
        let randomInt = Int.random(in: 0..<6)
        
        return colors[Int(randomInt)]
    }
    
    class func getDashColor(digits: Int) -> UIColor {
        //let colors = [DASH_RED, DASH_RED, BRILLIANT_ROSE, ORANGISH, PURPLISH, BLUISH, GREENISH]
        let colors = [DASH_RED, DASH_RED, ORANGISH, PINKISH, PURPLISH, BLUISH, GREENISH]
        
        if digits < 7 {
            return colors[Int(digits)]
        } else {
            return GREENISH
        }
    }
    
    /// For converting Hex-based colors
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        }
        self.init(displayP3Red: r, green: g, blue: b, alpha: a)
    }
    
    // Returns random generated color.
    public static var random: UIColor {
        srandom(arc4random())
        var red: Double = 0
        
        while (red < 0.1 || red > 0.84) {
            red = drand48()
        }
        
        var green: Double = 0
        while (green < 0.1 || green > 0.84) {
            green = drand48()
        }
        
        var blue: Double = 0
        while (blue < 0.1 || blue > 0.84) {
            blue = drand48()
        }
        
        return .init(displayP3Red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
    }
    
    public static func colorHash(name: String?) -> UIColor {
        guard let name = name else {
            return .red
        }
        
        var nameValue = 0
        for character in name {
            let characterString = String(character)
            let scalars = characterString.unicodeScalars
            nameValue += Int(scalars[scalars.startIndex].value)
        }
        
        var r = Float((nameValue * 123) % 51) / 51
        var g = Float((nameValue * 321) % 73) / 73
        var b = Float((nameValue * 213) % 91) / 91
        
        let defaultValue: Float = 0.84
        r = min(max(r, 0.1), defaultValue)
        g = min(max(g, 0.1), defaultValue)
        b = min(max(b, 0.1), defaultValue)
        
        return .init(displayP3Red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0)
    }
    
}
