//
//  ImageGalleryViewModel.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//


import Foundation

struct ImageGalleryViewModel {
  let images: [String]
  private var rawImages: [String]
  
  init(section: Section) {
    self.rawImages = section.images ?? []
    self.images = Array(rawImages.dropFirst())
  }
  
  func imageURL(at index: Int) -> URL? {
    guard index < images.count else { return nil }
    return URL(string: images[index])
  }
  
  var numberOfImages: Int {
    images.count
  }
  
  var mainImageURL: URL? {
    guard let first = rawImages.first else { return nil }
    return URL(string: first)
  }
}
