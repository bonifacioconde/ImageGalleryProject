//
//  Constants.swift
//  ImageGalleryProject
//
//  Created by Boni Foodics on 4/20/25.
//

import UIKit

func generateFont(from style: LabelStyle?) -> UIFont {
  let size = CGFloat((style?.size ?? 1) * 14)
  let baseDescriptor = UIFont.systemFont(ofSize: size).fontDescriptor
  var traits: UIFontDescriptor.SymbolicTraits = []

  if style?.bold == true { traits.insert(.traitBold) }
  if style?.italic == true { traits.insert(.traitItalic) }

  if let newDescriptor = baseDescriptor.withSymbolicTraits(traits) {
    return UIFont(descriptor: newDescriptor, size: size)
  } else if style?.bold == true {
    return UIFont.systemFont(ofSize: size, weight: .black)
  } else if style?.italic == true {
    return UIFont.italicSystemFont(ofSize: size)
  } else {
    return UIFont.systemFont(ofSize: size)
  }
}

func hexToColor(_ hex: String?) -> UIColor {
  guard let hex = hex?.replacingOccurrences(of: "#", with: "") else { return .black }
  var rgb: UInt64 = 0
  Scanner(string: hex).scanHexInt64(&rgb)
  return UIColor(
    red: CGFloat((rgb >> 16) & 0xFF) / 255,
    green: CGFloat((rgb >> 8) & 0xFF) / 255,
    blue: CGFloat(rgb & 0xFF) / 255,
    alpha: 1.0
  )
}

func alignmentFromString(_ string: String?) -> NSTextAlignment {
  switch string?.lowercased() {
    case "left": return .left
    case "right": return .right
    case "center": return .center
    case "justified": return .justified
    case "natural": return .natural
    default: return .natural
  }
}

func numLineFromString(_ string: String?) -> Int {
  switch string?.lowercased() {
    case "oneline": return 1
    case "twoline": return 2
    case "threeline": return 3
    default: return 0
  }
}
