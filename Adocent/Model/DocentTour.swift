//
//  DocentTour.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/07.
//

import Foundation

#if LOCAL_API
struct DocentTour: Codable, Identifiable {
    var id: Int
    var title: String
    var commentary: String
    var tour_guide: String
    var image_url: String
    
    init() {
        self.id = 0
        self.title = ""
        self.commentary = ""
        self.tour_guide = ""
        self.image_url = ""
    }
}
#else
struct DocentTour: Codable {
//    var artwork_intro_url: String
    var artwork_size: String
//    var artwork_intro_url_videoId: String
    var exhibition_img_path: String
    var artwork_location: String
    var exhibition_inline_text: String
    var artwork_img_alt: String
    var exhibition_img_alt: String
    var exhibition_map_img_alt: String
    var exhibition_end_date: String
    var exhibition_intro_url: String
    var artwork_view_url_videoId: String
//    var detail_intro: DetailView
    var exhibition_id: Int
    var venue_addr: String
    var lang: String
    var venue_id: Int
    var artwork_img_path: String
    var reg_admin_code: Int
    var artwork_intro_playtime: String
    var exhibition_start_date: String
    var artwork_view_url: String
    var venue_text: String
    var use_yn: String
    var artwork_view_playtime: String
    var artwork_title: String
    var del_yn: String
    var reg_date: String
    var exhibition_nm: String
    var artwork_artist_nm: String
    var artwork_text: String
    var edit_admin_code: Int
    var artwork_material: String
    var artwork_tag: String
    var venue_nm: String
    var artwork_id: Int
    var edit_date: String
    var artwork_date: String
    var exhibition_text: String
    
    init() {
//        self.artwork_intro_url = ""
        self.artwork_size = ""
//        self.artwork_intro_url_videoId = ""
        self.exhibition_img_path = ""
        self.artwork_location = ""
        self.exhibition_inline_text = ""
        self.artwork_img_alt = ""
        self.exhibition_img_alt = ""
        self.exhibition_map_img_alt = ""
        self.exhibition_end_date = ""
        self.exhibition_intro_url = ""
        self.artwork_view_url_videoId = ""
//        self.detail_intro = DetailView()
        self.exhibition_id = 0
        self.venue_addr = ""
        self.lang = ""
        self.venue_id = 0
        self.artwork_img_path = ""
        self.reg_admin_code = 0
        self.artwork_intro_playtime = ""
        self.exhibition_start_date = ""
        self.artwork_view_url = ""
        self.venue_text = ""
        self.use_yn = ""
        self.artwork_view_playtime = ""
        self.artwork_title = ""
        self.del_yn = ""
        self.reg_date = ""
        self.exhibition_nm = ""
        self.artwork_artist_nm = ""
        self.artwork_text = ""
        self.edit_admin_code = 0
        self.artwork_material = ""
        self.artwork_tag = ""
        self.venue_nm = ""
        self.artwork_id = 0
        self.edit_date = ""
        self.artwork_date = ""
        self.exhibition_text = ""
    }
}
#endif
