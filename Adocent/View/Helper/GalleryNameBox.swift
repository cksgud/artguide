//
//  GalleryNameBox.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/04.
//

import SwiftUI

struct GalleryNameBox: View {
    var galleryName: String
    var foregroundColor: Color
    
    var body: some View {
        Text(galleryName)
            .font(Font.custom("Arvo", size: 14))
            .foregroundColor(foregroundColor)
            .padding(.top, getCustomizedScreenHeight(15))
            .padding(.bottom, getCustomizedScreenHeight(15))
            .padding(.leading, getCustomizedScreenWidth(24))
            .padding(.trailing, getCustomizedScreenWidth(24))
            .border(foregroundColor)
            .padding(.top, getCustomizedScreenWidth(7))
    }
}

struct GalleryNameBox_Previews: PreviewProvider {
    static var previews: some View {
        GalleryNameBox(galleryName: String(), foregroundColor: .black)
    }
}
