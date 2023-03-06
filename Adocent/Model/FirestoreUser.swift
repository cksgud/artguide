//
//  FirestoreUser.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/24.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

struct FirestoreUser: Codable, Identifiable {
    @DocumentID var id: String?
    var loginId: String
    var loginType: String
    var profileName: String
    var profileImageName: String
    var profileImage: Image {
        Image(profileImageName)
    }
    var exhibitionIds: String
    var workIds: String
    var favoriteWorkIds: String
    var favortieGalleryIds: String
    var registerDate: String
    
    init() {
        self.loginId = ""
        self.loginType = ""
        self.profileName = "홍길동"
        self.profileImageName = "twinlake"
        self.exhibitionIds = ""
        self.workIds = ""
        self.favoriteWorkIds = ""
        self.favortieGalleryIds = ""
        self.registerDate = ""
    }
}
