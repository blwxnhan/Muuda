//
//  UIColor+.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

// MARK: - UIColor extension
extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
            
        assert(hexFormatted.count == 6, "Invalid hex code used.")
            
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    static let first: UIColor = UIColor(hexCode: "d9cbb4")
    static let second: UIColor = UIColor(hexCode: "c0c0c0")
    static let third: UIColor = UIColor(hexCode: "f5f5f5")
    static let fourth: UIColor = UIColor(hexCode: "b0c4de")
    static let fifth: UIColor = UIColor(hexCode: "eee5d3")
    static let myGray: UIColor = UIColor(hexCode: "d9d9d9")
}
