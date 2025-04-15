//
//  FeedController.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//

import Foundation
import UIKit

final class FeedController: UIViewController {
  var viewModel: FeedViewModelProtocol! = FeedViewModel(jsonName: "ios-project_image-gallery")
  
  @IBOutlet private(set) var collectionView: UICollectionView!
}

// MARK: - Lifecycle

extension FeedController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
}

// MARK: - Setup

private extension FeedController {
  func setup() {
    collectionView.contentInsetAdjustmentBehavior = .never
    
    collectionView.register(
      UINib(nibName: ImageGalleryCell.identifier, bundle: nil),
      forCellWithReuseIdentifier: ImageGalleryCell.identifier
    )
    collectionView.register(
      UINib(nibName: CustomCollectionCell.identifier, bundle: nil),
      forCellWithReuseIdentifier: CustomCollectionCell.identifier
    )
  }
}

// MARK: - Actions

private extension FeedController {
  //  @IBAction
  //  func someButtonTapped(_ sender: Any) {
  //    viewModel.someFunction2(
  //      param1: 0,
  //      param2: "",
  //      onSuccess: handleSomeSuccess(),
  //      onError: handleError()
  //    )
  //  }
}

// MARK: - Event Handlers

private extension FeedController {
  //  func handleSomeSuccess() -> VoidResult {
  //    return { [weak self] in
  //      guard let self = self else { return }
  //      // TODO: Do something here
  //    }
  //  }
}

// MARK: - Helpers

private extension FeedController {
  
}

// MARK: - UICollectionViewDataSource

extension FeedController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.sectionVMs.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let sectionVM = viewModel.sectionVMs[indexPath.row]
    
    switch sectionVM.section.sectionType {
    case .tableCell:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: CustomCollectionCell.identifier,
        for: indexPath
      ) as? CustomCollectionCell else {
          fatalError("CustomCollectionCell not registered or wrong class")
      }
      
      cell.viewModel = sectionVM
      return cell
      
    case .imageGallery:
      let galleryVM = ImageGalleryViewModel(section: sectionVM.section)
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ImageGalleryCell.identifier,
        for: indexPath
      ) as? ImageGalleryCell else {
          fatalError("ImageGalleryCell not registered or wrong class")
      }
      cell.viewModel = galleryVM
      return cell
      
    case .unknown:
      return UICollectionViewCell()
    }
  }
}

// MARK: -

extension FeedController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let rawHeight = viewModel.sectionVMs[indexPath.item].height
    let height = max(1, rawHeight) // clamp to avoid negative sizes
    return CGSize(width: collectionView.frame.width, height: height)
  }
}
