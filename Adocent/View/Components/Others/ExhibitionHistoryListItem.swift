//
//  ExhibitionHistoryListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/27.
//

import SwiftUI

#if LOCAL_API
struct ExhibitionHistoryListItem: View {
    var exhibition: Exhibition
    var galleryList: [Gallery]
    var foregroundColor: Color
    @State var galleryName = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(withURL: exhibition.image_url)
                .frame(width: getCustomizedScreenWidth(165), height: getCustomizedScreenWidth(165))
            
            Text("\(exhibition.start_date) - \(exhibition.end_date)")
                .multilineTextAlignment(.leading)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(foregroundColor)
                .opacity(0.7)
                .padding(.top, getCustomizedScreenHeight(2))
                .padding(.bottom, getCustomizedScreenHeight(-2))
                .offset(y: getCustomizedScreenHeight(-2))
            
            Text(exhibition.name)
                .multilineTextAlignment(.leading)
                .font(Font.custom("Arvo", size: 18))
                .foregroundColor(foregroundColor)
                .padding(.bottom, getCustomizedScreenHeight(-6))
                .offset(y: getCustomizedScreenHeight(-6))
            
            Text(galleryName)
                .multilineTextAlignment(.leading)
                .foregroundColor(foregroundColor)
                .font(Font.custom("Pretendard", size: 14))
                .opacity(0.7)
        }
        .frame(width: getCustomizedScreenWidth(165))
        .onAppear() {
            for gallery in galleryList {
                if gallery.id == exhibition.gallery_id {
                    galleryName = gallery.name
                }
            }
        }
    }
}

struct ExhibitionHistoryListItem_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionHistoryListItem(exhibition: Exhibition(), galleryList: [Gallery](), foregroundColor: .black)
    }
}
#else
struct ExhibitionHistoryListItem: View {
    var exhibition: Exhibition
    var galleryList: [Gallery]
    var foregroundColor: Color
    @State var galleryName = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(withURL: adminAddress + exhibition.exhibition_img_path)
                .frame(width: getCustomizedScreenWidth(165), height: getCustomizedScreenWidth(165))
            
            Text("\(exhibition.exhibition_start_date) - \(exhibition.exhibition_end_date)")
                .multilineTextAlignment(.leading)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(foregroundColor)
                .opacity(0.7)
                .padding(.top, getCustomizedScreenHeight(2))
                .padding(.bottom, getCustomizedScreenHeight(-2))
                .offset(y: getCustomizedScreenHeight(-2))
            
            Text(exhibition.exhibition_nm)
                .multilineTextAlignment(.leading)
                .font(Font.custom("Arvo", size: 18))
                .foregroundColor(foregroundColor)
                .padding(.bottom, getCustomizedScreenHeight(-6))
                .offset(y: getCustomizedScreenHeight(-6))
            
            Text(galleryName)
                .multilineTextAlignment(.leading)
                .foregroundColor(foregroundColor)
                .font(Font.custom("Pretendard", size: 14))
                .opacity(0.7)
        }
        .frame(width: getCustomizedScreenWidth(165))
        .onAppear() {
            galleryName = exhibition.venue_nm
        }
    }
}

struct ExhibitionHistoryListItem_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionHistoryListItem(exhibition: Exhibition(), galleryList: [Gallery](), foregroundColor: .black)
    }
}
#endif
