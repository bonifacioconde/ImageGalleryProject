//
//  SectionViewModel.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//

import UIKit

struct SectionViewModel {
  private let sectionData: Section
  init(section: Section) {
    self.sectionData = section
  }
}

// MARK: - Private Getters

private extension SectionViewModel {
  var topText: String? { section.styles?.topLabelText }
  var centerText: String? { section.styles?.centerLabelText }
  var bottomText: String? { section.styles?.bottomLabelText }
  
  var topAlignment: NSTextAlignment {
    alignmentFromString(section.styles?.topLabelStyles?.textAlign)
  }

  var centerAlignment: NSTextAlignment {
    alignmentFromString(section.styles?.centerLabelStyles?.textAlign)
  }

  var bottomAlignment: NSTextAlignment {
    alignmentFromString(section.styles?.bottomLabelStyles?.textAlign)
  }
  
  var topAttributes: [NSAttributedString.Key: Any] {
    return textAttributes(
      for: section.styles?.topLabelStyles,
      font: topFont,
      color: topColor,
      alignment: topAlignment)
  }

  var centerAttributes: [NSAttributedString.Key: Any] {
    return textAttributes(
      for: section.styles?.centerLabelStyles,
      font: centerFont,
      color: centerColor,
      alignment: centerAlignment)
  }
  
  var bottomAttributes: [NSAttributedString.Key: Any] {
    return textAttributes(
      for: section.styles?.bottomLabelStyles,
      font: bottomFont,
      color: bottomColor,
      alignment: bottomAlignment)
  }
  
  var centerFont: UIFont {
    let style = section.styles?.centerLabelStyles
    return generateFont(from: style)
  }
  
  var topFont: UIFont {
    let style = section.styles?.topLabelStyles
    return generateFont(from: style)
  }

  var bottomFont: UIFont {
    let style = section.styles?.bottomLabelStyles
    return generateFont(from: style)
  }
}

// MARK: - Helpers

private extension SectionViewModel {
  func generateFont(from style: LabelStyle?) -> UIFont {
    let size = CGFloat((style?.size ?? 1) * 13) //* scaleFactor
    var font = UIFont.systemFont(ofSize: size)
    var descriptor = UIFont.systemFont(ofSize: size).fontDescriptor
    descriptor = descriptor.withSymbolicTraits([.traitBold, .traitItalic]) ?? descriptor
    
    if style?.bold == true && style?.italic == true {
      font = UIFont(descriptor: descriptor, size: size)
    } else if style?.bold == true {
      font = UIFont.boldSystemFont(ofSize: size)
    } else if style?.italic == true {
      font = UIFont.italicSystemFont(ofSize: size)
    }
    return font
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

  func textAttributes(
    for style: LabelStyle?,
    font: UIFont,
    color: UIColor,
    alignment: NSTextAlignment
  ) -> [NSAttributedString.Key: Any] {
    var attributes: [NSAttributedString.Key: Any] = [
      .font: font,
      .foregroundColor: color,
    ]

    if style?.underline == true {
      attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
    }

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    attributes[.paragraphStyle] = paragraphStyle

    return attributes
  }
}

// MARK: - Methods

extension SectionViewModel {
  var section: Section {
    return sectionData
  }
  
  var imageURL: URL? {
    guard let urlString = section.styles?.backgroundImageUrl else { return nil }
    return URL(string: urlString)
  }
  
  var centerColor: UIColor {
    return hexToColor(section.styles?.centerLabelStyles?.color)
  }

  var topColor: UIColor {
    return hexToColor(section.styles?.topLabelStyles?.color)
  }

  var bottomColor: UIColor {
    return hexToColor(section.styles?.bottomLabelStyles?.color)
  }

  
  var backgroundColor: UIColor {
    return hexToColor(section.styles?.backgroundColor)
  }
  
  var height: CGFloat {
    CGFloat(section.styles?.cellHeight ?? 100) //* scaleFactor
  }
  
  var topAttributedText: NSAttributedString? {
    NSAttributedString(
      string: topText ?? "",
      attributes: topAttributes)
  }
  
  var centerAttributedText: NSAttributedString? {
    NSAttributedString(
      string: centerText ?? "",
      attributes: centerAttributes)
  }
  
  var bottomAttributedText: NSAttributedString? {
    NSAttributedString(
      string: bottomText ?? "",
      attributes: bottomAttributes)
  }
}
