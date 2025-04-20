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
  private var styledLabel: StyledLabel?
  
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
    styledLabel?.removeFromSuperview()
    guard viewModel.height > 10 else { return }

    styledLabel = StyledLabel(
      text: viewModel.contentText ?? "",
      style: viewModel.contentLabelStyle,
      layout: viewModel.section.styles?.layout
    )

    if let label = styledLabel {
      contentView.addSubview(label)
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      ])
      
      switch viewModel.section.styles?.bottomLabelStyles?.vAlign?.lowercased() {
      case "top":
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
      case "bottom":
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
      default:
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
      }
    }
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
