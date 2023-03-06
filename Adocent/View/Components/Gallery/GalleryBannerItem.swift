//
//  GalleryBannerItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI

#if LOCAL_API
struct GalleryBannerItem: View {
    var galleryBanner: GalleryBanner
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: galleryBanner.image_url)
        }
    }
}
#else
struct GalleryBannerItem: View {
    var galleryBanner: GalleryBanner
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: galleryBanner.image_url)
        }
    }
}
#endif

struct GalleryBannerItem_Previews: PreviewProvider {
    static var previews: some View {
        GalleryBannerItem(galleryBanner: GalleryBanner())
    }
}
