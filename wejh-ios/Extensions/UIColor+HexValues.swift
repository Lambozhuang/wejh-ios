//
//  UIColor+HexValues.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/3.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

// Parts of this file is taken from https://github.com/yeahdongcn/UIColor-Hex-Swift,
// Modified to add DisplayP3 color hex support.

import UIKit

extension UIColor {

  /**
   The shorthand three-digit hexadecimal representation of color.
   #RGB defines to the color #RRGGBB.

   - parameter hex3: Three-digit hexadecimal value.
   - parameter alpha: 0.0 - 1.0. The default is 1.0.
   */
  public convenience init(hex3: UInt16, alpha: CGFloat = 1, displayP3: Bool = false) {
    let divisor = CGFloat(15)
    let red = CGFloat((hex3 & 0xF00) >> 8) / divisor
    let green = CGFloat((hex3 & 0x0F0) >> 4) / divisor
    let blue = CGFloat(hex3 & 0x00F) / divisor
    if displayP3 {
      self.init(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    } else {
      self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  /**
   The shorthand four-digit hexadecimal representation of color with alpha.
   #RGBA defines to the color #RRGGBBAA.

   - parameter hex4: Four-digit hexadecimal value.
   */
  public convenience init(hex4: UInt16, displayP3: Bool = false) {
    let divisor = CGFloat(15)
    let red = CGFloat((hex4 & 0xF000) >> 12) / divisor
    let green = CGFloat((hex4 & 0x0F00) >> 8) / divisor
    let blue = CGFloat((hex4 & 0x00F0) >> 4) / divisor
    let alpha = CGFloat(hex4 & 0x000F) / divisor
    if displayP3 {
      self.init(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    } else {
      self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  /**
   The six-digit hexadecimal representation of color of the form #RRGGBB.

   - parameter hex6: Six-digit hexadecimal value.
   */
  public convenience init(hex6: UInt32, alpha: CGFloat = 1, displayP3: Bool = false) {
    let divisor = CGFloat(255)
    let red = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
    let green = CGFloat((hex6 & 0x00FF00) >> 8) / divisor
    let blue = CGFloat(hex6 & 0x0000FF) / divisor
    self.init(red: red, green: green, blue: blue, alpha: alpha)
    if displayP3 {
      self.init(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    } else {
      self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  /**
   The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.

   - parameter hex8: Eight-digit hexadecimal value.
   */
  public convenience init(hex8: UInt32, displayP3: Bool = false) {
    let divisor = CGFloat(255)
    let red = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
    let green = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
    let blue = CGFloat((hex8 & 0x0000FF00) >> 8) / divisor
    let alpha = CGFloat(hex8 & 0x000000FF) / divisor
    if displayP3 {
      self.init(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    } else {
      self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
  }

  /**
   The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.

   - parameter rgba: String value.
   */
  public convenience init?(rgba: String, displayP3: Bool = false) {
    guard rgba.hasPrefix("#") else {
      return nil
    }

    let hexString: String = String(rgba[String.Index(utf16Offset: 1, in: rgba)...])
    var hexValue: UInt32 = 0

    guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
      return nil
    }

    switch (hexString.count) {
    case 3:
      self.init(hex3: UInt16(hexValue), displayP3: displayP3)
    case 4:
      self.init(hex4: UInt16(hexValue), displayP3: displayP3)
    case 6:
      self.init(hex6: hexValue, displayP3: displayP3)
    case 8:
      self.init(hex8: hexValue, displayP3: displayP3)
    default:
      return nil
    }
  }

  /**
   The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.

   - parameter rgba: String value.
   */
  public convenience init(_ rgba: String, displayP3: Bool = false, defaultColor: UIColor = UIColor.clear) {
    guard let color = UIColor(rgba: rgba, displayP3: displayP3) else {
      self.init(cgColor: defaultColor.cgColor)
      return
    }
    self.init(cgColor: color.cgColor)
  }

  /**
   Hex string of a UIColor instance, throws error.

   - parameter includeAlpha: Whether the alpha should be included.
   */
  public func hexString(_ includeAlpha: Bool = true) throws -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)

    guard r >= 0 && r <= 1 && g >= 0 && g <= 1 && b >= 0 && b <= 1 else {
      return ""
    }

    if (includeAlpha) {
      return String(format: "#%02X%02X%02X%02X",
          Int(round(r * 255)), Int(round(g * 255)),
          Int(round(b * 255)), Int(round(a * 255)))
    } else {
      return String(format: "#%02X%02X%02X", Int(round(r * 255)),
          Int(round(g * 255)), Int(round(b * 255)))
    }
  }

}
