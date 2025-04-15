//
//  JSONLoader.swift
//  ImageGalleryProject
//
//  Created by Boni on 4/13/25.
//


import Foundation

class JSONLoader {
  static func loadSections(from filename: String) -> [Section] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
          let data = try? Data(contentsOf: url) else { return [] }
    
    do {
      let decoder = JSONDecoder()
      let project = try decoder.decode(Project.self, from: data)
      return project.sections
    } catch {
      print("Error parsing JSON: \(error)")
      return []
    }
  }
}

struct Project: Codable {
  let sections: [Section]
}
