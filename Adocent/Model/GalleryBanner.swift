//
//  GalleryBanner.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/18.
//

import Foundation

struct GalleryBanner : Codable {
    var gallery_id: Int
    var number: Int
    var image_url: String
    var link: String
    var image_title: String
    var public_yn: Bool
    var order: Int
    var current_window_yn: Bool
    
    init() {
        self.gallery_id = 0
        self.number = 0
        self.image_url = ""
        self.link = ""
        self.image_title = ""
        self.public_yn = false
        self.order = 0
        self.current_window_yn = false
    }
}
