//
//  User.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/07.
//

import Foundation

struct User: Codable {
    var id: Int
    var login_id: String
    var login_type: String
//    var register_date: String
    
    init() {
        self.id = 0
        self.login_id = ""
        self.login_type = ""
//        self.register_date = ""
    }
}
