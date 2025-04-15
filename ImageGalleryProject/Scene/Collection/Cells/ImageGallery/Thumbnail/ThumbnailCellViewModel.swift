//
//  ThumbnailCellViewModel.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/14/25.
//

import Foundation

final class ThumbnailCellViewModel: ThumbnailCellViewModelProtocol {
  private let urlString: String?

  init(
    urlString: String?
  ) {
    self.urlString = urlString
  }
}

// MARK: - Getters

extension ThumbnailCellViewModel {
  var imageURL: URL? {
    guard let urlString = urlString else { return nil }
    return URL(string: urlString)
  }
}
