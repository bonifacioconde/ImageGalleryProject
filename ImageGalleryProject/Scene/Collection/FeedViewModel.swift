//
//  FeedViewModel.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//

import Foundation

final class FeedViewModel: FeedViewModelProtocol {
  private let jsonName: String
  private var _sectionVMs: [SectionViewModel]?
//  var onSomeCallbackEvent: VoidResult?
//
//  private(set) var someVariable1: Int = 0
//
//  private let model: SomeModel
//  private let service: SomeService
//
  init(
    jsonName: String 
  ) {
    self.jsonName = jsonName
    
    setup()
  }
}

// MARK: - Setup

private extension FeedViewModel {
  func setup() {
    _sectionVMs = JSONLoader.loadSections(from: jsonName)
      .map(SectionViewModel.init)
  }
}

// MARK: - Methods

extension FeedViewModel {
//  func someFunction1(param1: Int) {
//
//  }
//
//  func someFunction2(
//    param1: Int,
//    param2: String,
//    onSuccess: @escaping VoidResult,
//    onError: @escaping ErrorResult
//  ) {
//
//  }
}

// MARK: - Getters

extension FeedViewModel {
  var sectionVMs: [SectionViewModel] {
    guard _sectionVMs != nil else {
      return []
    }
    return _sectionVMs!
  }
}
