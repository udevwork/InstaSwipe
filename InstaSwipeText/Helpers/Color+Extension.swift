import Foundation
import UIKit
import SwiftUI

typealias HexadecimalString = String

extension UIColor {
    
    convenience init?(hex: HexadecimalString) {
        //prepare the hex string
        var hexProcessed = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexProcessed = hexProcessed.replacingOccurrences(of: "#", with: "")
        
        //set up variables
        //-
        //unsigned integer
        var rgb: UInt32 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        //alpha default = 1.0
        var a: CGFloat = 1.0
        let length = hexProcessed.count
        
        //Scanning the string with scanner for unsigned values
        guard Scanner(string: hexProcessed).scanHexInt32(&rgb) else {
            return nil
        }
        
        //extract colors based on hex lenght
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        //Creating UIColor instance with extracted values
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    
    // MARK: - Computed Properties
    
    var hexString: HexadecimalString? {
        return hexString()
    }
    
    // MARK: - From UIColor to Hex String
    
    //One param: indicates if alpha value is included or not (bool)
    
    func hexString(alpha: Bool = false) -> HexadecimalString? {
        
        //Safely unwrapping because components property is type [CGFloat]?
        //Also mage sure that it contains a minimum of 3 components
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        //extract colors
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        //if there is an alpha value extract it too
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        //create return string, round values with lroundf
        //REMEMBER: - String formats:
        // % defines the format specifier
        // 02 defines the length of the string
        // l casts the value to an unsigned long
        // X prints the value in hexadecimal
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        }
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
}

extension Color {
    
    static let lightGray = Color(uiColor: UIColor(hex: "E8F0FE")!)

    
    static let pastelPink = Color(red: 1.00, green: 0.85, blue: 0.87)
    static let pastelMint = Color(red: 0.80, green: 1.00, blue: 0.86)
    static let pastelLavender = Color(red: 0.89, green: 0.82, blue: 1.00)
    static let pastelPeach = Color(red: 1.00, green: 0.91, blue: 0.81)
    static let pastelYellow = Color(red: 1.00, green: 1.00, blue: 0.87)
    static let pastelBlue = Color(red: 0.84, green: 0.96, blue: 1.00)
    static let pastelGreen = Color(red: 0.80, green: 1.00, blue: 0.93)
    static let pastelGray = Color(red: 0.88, green: 0.88, blue: 0.88)
    static let pastelTan = Color(red: 0.98, green: 0.93, blue: 0.87)
    static let pastelAqua = Color(red: 0.74, green: 0.98, blue: 0.99)
    
    static let buttonBlue = Color(uiColor: UIColor(hex: "5A9CFF")!)
    static let buttonGreen = Color(uiColor: UIColor(hex: "14D6A7")!)
    static let buttonRed = Color(uiColor: UIColor(hex: "E44561")!)
    static let buttonGray = Color(uiColor: UIColor(hex: "464646")!)
    
    static let shadowColor = Color(uiColor: UIColor(hex: "E3EBF3")!)
    static let textColor = Color(uiColor: UIColor(hex: "193B68")!)
    static let secondaryTextColor = Color(uiColor: UIColor(hex: "929FB3")!)
    
    static let darkPastelPink = Color(red: 0.80, green: 0.55, blue: 0.57)
    static let darkPastelMint = Color(uiColor: UIColor(hex: "2DAA7D")!)
    static let darkPastelLavender = Color(red: 0.69, green: 0.62, blue: 0.80)
    static let darkPastelPeach = Color(red: 0.80, green: 0.71, blue: 0.61)
    static let darkPastelYellow = Color(red: 0.80, green: 0.80, blue: 0.57)
    static let darkPastelBlue = Color(red: 0.64, green: 0.76, blue: 0.80)
    static let darkPastelGreen = Color(red: 0.60, green: 0.80, blue: 0.73)
    static let darkPastelGray = Color(red: 0.68, green: 0.68, blue: 0.68)
    static let darkPastelTan = Color(red: 0.78, green: 0.73, blue: 0.67)
    static let darkPastelAqua = Color(red: 0.54, green: 0.78, blue: 0.79)
    
    
}
