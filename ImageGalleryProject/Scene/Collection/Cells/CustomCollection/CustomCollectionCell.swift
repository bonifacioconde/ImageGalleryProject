//
//  CustomCollectionCell.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//

import Foundation
import UIKit

final class CustomCollectionCell: UICollectionViewCell {
  static let identifier = "CustomCollectionCell"
  
  @IBOutlet private(set) var backgroundImageView: UIImageView!
  @IBOutlet private(set) var topLabel: UILabel!
  @IBOutlet private(set) var centerLabel: UILabel!
  @IBOutlet private(set) var bottomLabel: UILabel!
  
  var viewModel: SectionViewModel! {
    didSet {
      refresh()
    }
  }
}

// MARK: - Refresh

private extension CustomCollectionCell {
  func refresh() {
    guard viewModel != nil else { return }
    
    refreshLabel()
    
    backgroundColor = viewModel.backgroundColor
    
    if let url = viewModel.imageURL {
      loadImage(from: url)
    } else {
      backgroundImageView.image = nil
    }
  }
  
  func refreshLabel() {
    guard viewModel.height > 10 else {
      topLabel.text = ""
      centerLabel.text = ""
      bottomLabel.text = ""
      return
    }

    topLabel.attributedText = viewModel.topAttributedText
    centerLabel.attributedText = viewModel.centerAttributedText
    bottomLabel.attributedText = viewModel.bottomAttributedText
  }
}

// MARK: - Helpers

private extension CustomCollectionCell {
  func loadImage(from url: URL) {
    // Check cache first
    if let cachedImage = imageCache.object(forKey: url as NSURL) {
      self.backgroundImageView.image = cachedImage
      return
    }

    // If not cached, download
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
        // Cache the image
        imageCache.setObject(image, forKey: url as NSURL)

        DispatchQueue.main.async {
          self.backgroundImageView.image = image
        }
      }
    }
  }
}
