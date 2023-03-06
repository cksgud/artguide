//
//  Exhibition.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/07.
//

import Foundation

#if LOCAL_API
struct Exhibition: Codable, Identifiable {
    var id: Int
    var name: String
    var gallery_id: Int
    var start_date: String
    var end_date: String
    var tags: String
    var image_url: String
    var image_alt: String
    var video_url: String
    var commentary: String
    var open_yn: Bool
    var reg_admin_id: String
    var reg_admin_date: String
    var public_yn: Bool
    var update_admin_id: String
    var update_admin_date: String
    
    init() {
        self.id = 0
        self.name = "Trompe l'oeil-crisscross into reality"
        self.gallery_id = 0
        self.start_date = "2022.08.01"
        self.end_date = "10.31"
        self.tags = "#강영성 #김시현 #도진욱 #서유라"
        self.image_url = "https://static.wixstatic.com/media/520ee6_c64d0e69e7b54941817167a4b160328a~mv2.jpg/v1/fill/w_322,h_440,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/1000px-galleryBK-poster_final.jpg"
        self.image_alt = ""
        self.video_url = ""
        self.commentary = ""
        self.open_yn = false
        self.reg_admin_id = ""
        self.reg_admin_date = ""
        self.public_yn = false
        self.update_admin_id = ""
        self.update_admin_date = ""
    }
}
#else
struct Exhibition: Codable {
    var exhibition_id: Int
    var mapp_venue_id: Int
    var exhibition_start_date: String
    var exhibition_end_date: String
    var use_yn: String
    var reg_admin_code: Int
    var reg_date: String
    var edit_admin_code: Int
    var edit_date: String
    var lang: String
    var exhibition_nm: String
    var exhibition_img_path: String
    var exhibition_img_alt: String
    var exhibition_map_img_alt: String
    var exhibition_intro_url: String
    var exhibition_text: String
    var exhibition_inline_text: String
    var venue_nm: String
    
    init() {
        self.exhibition_id = 0
        self.mapp_venue_id = 0
        self.exhibition_start_date = ""
        self.exhibition_end_date = ""
        self.use_yn = ""
        self.reg_admin_code = 0
        self.reg_date = ""
        self.edit_admin_code = 0
        self.edit_date = ""
        self.lang = ""
        self.exhibition_nm = ""
        self.exhibition_img_path = ""
        self.exhibition_img_alt = ""
        self.exhibition_map_img_alt = ""
        self.exhibition_intro_url = ""
        self.exhibition_text = ""
        self.exhibition_inline_text = ""
        self.venue_nm = ""
    }
}
#endif
