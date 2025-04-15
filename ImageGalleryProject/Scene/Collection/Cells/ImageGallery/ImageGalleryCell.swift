//
//  ImageGalleryCell.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//

import Foundation
import UIKit

final class ImageGalleryCell: UICollectionViewCell {
  static let identifier = "ImageGalleryCell"
  
  @IBOutlet private(set) var thumbnailsCollectionView: UICollectionView!
  @IBOutlet private(set) var mainImageView: UIImageView!
  
  var viewModel: ImageGalleryViewModel! {
    didSet {
      refresh()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setup()
  }
}

// MARK: - Setup

private extension ImageGalleryCell {
  func setup() {
    thumbnailsCollectionView.contentInsetAdjustmentBehavior = .never
    
    thumbnailsCollectionView.register(
      UINib(nibName: ThumbnailCell.identifier, bundle: nil),
      forCellWithReuseIdentifier: ThumbnailCell.identifier
    )
  }
}

// MARK: - Refresh

private extension ImageGalleryCell {
  func refresh() {
    guard
      viewModel != nil,
      let imageURL = viewModel.mainImageURL
    else { return }
    
    loadImage(from: imageURL)
    
    thumbnailsCollectionView.reloadData()
  }
}


extension ImageGalleryCell: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    viewModel.numberOfImages
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ThumbnailCell.identifier,
      for: indexPath
    ) as? ThumbnailCell else {
        fatalError("ThumbnailCell not registered or wrong class")
    }
    cell.viewModel = ThumbnailCellViewModel(urlString: viewModel.images[indexPath.item])
    return cell
  }
}

private extension ImageGalleryCell {
  func loadImage(from url: URL) {
    // Check cache first
    if let cachedImage = imageCache.object(forKey: url as NSURL) {
      self.mainImageView.image = cachedImage
      return
    }

    // If not cached, download
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url),
         let image = UIImage(data: data) {
        // Cache the image
        imageCache.setObject(image, forKey: url as NSURL)

        DispatchQueue.main.async {
          self.mainImageView.image = image
        }
      }
    }
  }
}
