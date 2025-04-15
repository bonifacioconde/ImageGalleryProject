//
//  Section.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//


import Foundation

enum SectionType: String, Codable {
  case tableCell = "TableCell"
  case imageGallery = "ImageGallery"
  case unknown
  
  init(rawValue: String) {
    switch rawValue {
    case "TableCell": self = .tableCell
    case "ImageGallery": self = .imageGallery
    default: self = .unknown
    }
  }
}

struct Section: Codable {
  let sectionId: String
  let sectionType: SectionType
  let styles: Styles?
  let images: [String]?
}

struct Styles: Codable {
  let backgroundColor: String?
  let backgroundImageUrl: String?
  let cellHeight: Int?
  let layout: String?
  let centerLabelStyles: LabelStyle?
  let topLabelStyles: LabelStyle?
  let bottomLabelStyles: LabelStyle?
  let centerLabelText: String?
  let topLabelText: String?
  let bottomLabelText: String?
}

struct LabelStyle: Codable {
  let bold: Bool?
  let italic: Bool?
  let underline: Bool?
  let size: Double?
  let textAlign: String?
  let vAlign: String?
  let color: String?
}
