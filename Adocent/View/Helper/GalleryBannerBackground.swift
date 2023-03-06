//
//  GalleryBannerBackground.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/01.
//

import SwiftUI

struct GalleryBannerBackground: View {
    var body: some View {
        VStack {
            Color.customBlue
                .ignoresSafeArea()
                .frame(height: getCustomizedScreenHeight(410))
            Color.white
                .ignoresSafeArea()
                .frame(height: getCustomizedScreenHeight(402))
        }
    }
}

struct GalleryBannerBackground_Previews: PreviewProvider {
    static var previews: some View {
        GalleryBannerBackground()
    }
}
