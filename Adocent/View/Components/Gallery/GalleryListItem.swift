//
//  GalleryListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/20.
//

import SwiftUI

struct GalleryListItem: View {
    var galleryName: String
    
    var body: some View {
        Text(galleryName)
            .font(Font.custom("Arvo", size: 14))
            .foregroundColor(.white)
            .padding(.top, getCustomizedScreenHeight(15))
            .padding(.bottom, getCustomizedScreenHeight(15))
            .padding(.leading, getCustomizedScreenWidth(24))
            .padding(.trailing, getCustomizedScreenWidth(24))
            .border(Color.white)
            .padding(.top, getCustomizedScreenWidth(-10))
            .padding(.trailing, getCustomizedScreenWidth(-10))
    }
}

struct GalleryListItem_Previews: PreviewProvider {
    static var previews: some View {
        GalleryListItem(galleryName: String())
    }
}
