//
//  ThumbnailCell.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/14/25.
//

import Foundation
import UIKit

final class ThumbnailCell: UICollectionViewCell {
  static let identifier = "ThumbnailCell"
  
  @IBOutlet private(set) var imageView: UIImageView!
  
  var viewModel: ThumbnailCellViewModelProtocol! {
    didSet {
      bind()
      refresh()
    }
  }
  
  // @IBOutlet private(set) var label: UILabel!
  
  override func awakeFromNib() {
    setup()
  }
}

// MARK: - Setup

private extension ThumbnailCell {
  func setup() {

  }
}

// MARK: - Bindings

private extension ThumbnailCell {
  // NOTE: Reserve the Bindings extension for Combine/reactive stuff only

  func bind() {
    guard viewModel != nil else { return }
  }
}

// MARK: - Refresh

private extension ThumbnailCell {
  func refresh() {
    guard
      viewModel != nil,
      let imageURL = viewModel.imageURL
    else { return }
    
    loadImage(from: imageURL)
  }
}

// MARK: - Helpers

private extension ThumbnailCell {

}

private extension ThumbnailCell {
  func loadImage(from url: URL) {
    // Check cache first
    if let cachedImage = imageCache.object(forKey: url as NSURL) {
      self.imageView.image = cachedImage
      return
    }

    // If not cached, download
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
        // Cache the image
        imageCache.setObject(image, forKey: url as NSURL)

        DispatchQueue.main.async {
          self.imageView.image = image
        }
      }
    }
  }
}
