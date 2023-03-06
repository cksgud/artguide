//
//  DetailView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/12.
//

import Foundation

struct DetailView: Codable {
    var kind: String
    var etag: String
    var id: String
    var contentDetails: ContentDetails
    
    init() {
        self.kind = ""
        self.etag = ""
        self.id = ""
        self.contentDetails = ContentDetails()
    }
}
