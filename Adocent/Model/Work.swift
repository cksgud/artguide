//
//  Work.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/07.
//

import Foundation

#if LOCAL_API
struct Work: Codable, Identifiable, Comparable {
    static func < (lhs: Work, rhs: Work) -> Bool {
        lhs.name > rhs.name
    }

    var id: Int
    var name: String
//    var exhibition_name: String // nil 값 처리 후 주석해제 필요
    var location: String
    var image_url: String
    var image_alt: String
    var video_url: String
    var video_playtime: String
    var commentary: String
    var delete_yn_registered: Bool
    var public_yn: Bool
    var artist_name: String
    var featured_yn: Bool
    var tags: String
    var reg_admin_id: String
    var reg_admin_date: String
    var update_admin_id: String
    var update_admin_date: String
    
    init() {
        self.id = 0
        self.name = ""
//        self.exhibition_name = "" // nil 값 처리 후 주석해제 필요
        self.location = ""
        self.image_url = ""
        self.image_alt = ""
        self.video_url = ""
        self.video_playtime = ""
        self.commentary = ""
        self.delete_yn_registered = false
        self.public_yn = false
        self.artist_name = ""
        self.featured_yn = false
        self.tags = ""
        self.reg_admin_id = ""
        self.reg_admin_date = ""
        self.update_admin_id = ""
        self.update_admin_date = ""
    }
}

#else
struct Work: Codable, Comparable {
    static func == (lhs: Work, rhs: Work) -> Bool {
        return lhs.artwork_id == rhs.artwork_id
    }
    
    static func < (lhs: Work, rhs: Work) -> Bool {
        lhs.artwork_title > rhs.artwork_title
    }
    
    var artwork_size: String
//    var artwork_intro_url_videoId: Int
    var main_exhibition_id: Int
    var artwork_location: String
    var artwork_img_alt: String
    var exhibition_nms: String
//    var artwork_view_url_videoId: String
//    var detail_intro: String
    var lang: String
//    var detail_view: DetailView
    var venue_id: Int
    var artwork_img_path: String
    var reg_admin_code: Int
    var artwork_intro_playtime: String
    var artwork_view_url: String
    var use_yn: String
    var artwork_view_playtime: String
    var artwork_title: String
    var del_yn: String
    var reg_date: String
    var artwork_artist_nm: String
    var artwork_text: String
    var edit_admin_code: Int
    var artwork_material: String
    var artwork_tag: String
    var artwork_id: Int
    var edit_date: String
    var artwork_date: String
    
    internal init() {
        self.artwork_size = ""
//        self.artwork_intro_url_videoId = 0
        self.main_exhibition_id = 0
        self.artwork_location = ""
        self.artwork_img_alt = ""
        self.exhibition_nms = ""
//        self.artwork_view_url_videoId = ""
//        self.detail_intro = ""
        self.lang = ""
//        self.detail_view = DetailView()
        self.venue_id = 0
        self.artwork_img_path = ""
        self.reg_admin_code = 0
        self.artwork_intro_playtime = ""
        self.artwork_view_url = ""
        self.use_yn = ""
        self.artwork_view_playtime = ""
        self.artwork_title = ""
        self.del_yn = ""
        self.reg_date = ""
        self.artwork_artist_nm = ""
        self.artwork_text = ""
        self.edit_admin_code = 0
        self.artwork_material = ""
        self.artwork_tag = ""
        self.artwork_id = 0
        self.edit_date = ""
        self.artwork_date = ""
    }
    
    public init(from decoder: Decoder) {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        self.artwork_size = (try? values?.decode(String.self, forKey: .artwork_size)) ?? ""
//        self.artwork_intro_url_videoId = 0
        self.main_exhibition_id = (try? values?.decode(Int.self, forKey: .main_exhibition_id)) ?? 0
        self.artwork_location = (try? values?.decode(String.self, forKey: .artwork_location)) ?? ""
        self.artwork_img_alt = (try? values?.decode(String.self, forKey: .artwork_img_alt)) ?? ""
        self.exhibition_nms = (try? values?.decode(String.self, forKey: .exhibition_nms)) ?? ""
//        self.artwork_view_url_videoId = ""
//        self.detail_intro = ""
        self.lang = (try? values?.decode(String.self, forKey: .lang)) ?? ""
//        self.detail_view = DetailView()
        self.venue_id = (try? values?.decode(Int.self, forKey: .venue_id)) ?? 0
        self.artwork_img_path = (try? values?.decode(String.self, forKey: .artwork_img_path)) ?? ""
        self.reg_admin_code = (try? values?.decode(Int.self, forKey: .reg_admin_code)) ?? 0
        self.artwork_intro_playtime = (try? values?.decode(String.self, forKey: .artwork_intro_playtime)) ?? ""
        self.artwork_view_url = (try? values?.decode(String.self, forKey: .artwork_view_url)) ?? ""
        self.use_yn = (try? values?.decode(String.self, forKey: .use_yn)) ?? ""
        self.artwork_view_playtime = (try? values?.decode(String.self, forKey: .artwork_view_playtime)) ?? ""
        self.artwork_title = (try? values?.decode(String.self, forKey: .artwork_title)) ?? ""
        self.del_yn = (try? values?.decode(String.self, forKey: .del_yn)) ?? ""
        self.reg_date = (try? values?.decode(String.self, forKey: .reg_date)) ?? ""
        self.artwork_artist_nm = (try? values?.decode(String.self, forKey: .artwork_artist_nm)) ?? ""
        self.artwork_text = (try? values?.decode(String.self, forKey: .artwork_text)) ?? ""
        self.edit_admin_code = (try? values?.decode(Int.self, forKey: .edit_admin_code)) ?? 0
        self.artwork_material = (try? values?.decode(String.self, forKey: .artwork_material)) ?? ""
        self.artwork_tag = (try? values?.decode(String.self, forKey: .artwork_tag)) ?? ""
        self.artwork_id = (try? values?.decode(Int.self, forKey: .artwork_id)) ?? 0
        self.edit_date = (try? values?.decode(String.self, forKey: .edit_date)) ?? ""
        self.artwork_date = (try? values?.decode(String.self, forKey: .artwork_date)) ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case artwork_size = "artwork_size"
//        case artwork_intro_url_videoId = 0
        case main_exhibition_id = "main_exhibition_id"
        case artwork_location = "artwork_location"
        case artwork_img_alt = "artwork_img_alt"
        case exhibition_nms = "exhibition_nms"
//        case artwork_view_url_videoId = "artwork_view_url_videoId"
//        case detail_intro = "detail_intro"
        case lang = "lang"
//        case detail_view = DetailView()
        case venue_id = "venue_id"
        case artwork_img_path = "artwork_img_path"
        case reg_admin_code = "reg_admin_code"
        case artwork_intro_playtime = "artwork_intro_playtime"
        case artwork_view_url = "artwork_view_url"
        case use_yn = "use_yn"
        case artwork_view_playtime = "artwork_view_playtime"
        case artwork_title = "artwork_title"
        case del_yn = "del_yn"
        case reg_date = "reg_date"
        case artwork_artist_nm = "artwork_artist_nm"
        case artwork_text = "artwork_text"
        case edit_admin_code = "edit_admin_code"
        case artwork_material = "artwork_material"
        case artwork_tag = "artwork_tag"
        case artwork_id = "artwork_id"
        case edit_date = "edit_date"
        case artwork_date = "artwork_date"
    }
}
#endif
