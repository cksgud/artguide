//
//  Gallery.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/18.
//

import Foundation

#if LOCAL_API
struct Gallery: Codable, Identifiable {
    var id: Int
    var name: String
    var address: String
    var operation_hours: String
    var public_yn: Bool
    
    init() {
        self.id = 0
        self.name = ""
        self.address = ""
        self.operation_hours = ""
        self.public_yn = false
    }
}
#else
struct Gallery: Codable {
    var urls: String
    var venue_text: String
    var venue_open_time: String
    var paths: String
    var use_yn: String
    var venue_addr: String
    var alts: String
    var venue_nm: String
    var lang: String
    var targets: String
    var venue_id: Int
    var del_yn: String
    
    init() {
        self.urls = ""
        self.venue_text = ""
        self.venue_open_time = ""
        self.paths = ""
        self.use_yn = ""
        self.venue_addr = ""
        self.alts = ""
        self.venue_nm = ""
        self.lang = ""
        self.targets = ""
        self.venue_id = 0
        self.del_yn = ""
    }
}
#endif
