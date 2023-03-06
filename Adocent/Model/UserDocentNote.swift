//
//  UserDocentNote.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import Foundation

#if LOCAL_API
struct UserDocentNote: Codable {
    var id: Int
    var login_id: String
    var type: String
    var target_id: Int
    var view_date: String
    
    init() {
        self.id = 0
        self.login_id = ""
        self.type = ""
        self.target_id = 0
        self.view_date = ""
    }
}
#else
struct UserDocentNote: Codable {
    var id: Int
    var login_id: String
    var target_type: String
    var target_id: Int
    var view_date: String
    
    init() {
        self.id = 0
        self.login_id = ""
        self.target_type = ""
        self.target_id = 0
        self.view_date = ""
    }
}
#endif
