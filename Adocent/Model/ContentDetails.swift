//
//  ContentDetails.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/12.
//

import Foundation

struct ContentDetails: Codable {
    var duration: String
    var dimension: String
    var definition: String
    var caption: String
    var licensedContent: Bool
    var contentRating: ContentRating
    var projection: String
    
    init() {
        self.duration = ""
        self.dimension = ""
        self.definition = ""
        self.caption = ""
        self.licensedContent = false
        self.contentRating = ContentRating()
        self.projection = ""
    }
}
