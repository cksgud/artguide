//
//  WorkListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

#if LOCAL_API
struct WorkListItem: View {
    var work: Work
    var foregroundColor: Color
    
    var body: some View {
        HStack {
            URLImage(withURL: work.image_url)
                .frame(width: getCustomizedScreenWidth(64), height: getCustomizedScreenHeight(64))
                .padding(.leading, getCustomizedScreenWidth(16))
            
            VStack(alignment: .leading) {
                Text(work.name)
                    .font(Font.custom("Pretendard-Medium", size: 18))
                    .foregroundColor(foregroundColor)
                
                Text("\(work.artist_name) | \(work.location)")
                    .font(Font.custom("Pretendard-Medium", size: 14))
                    .foregroundColor(foregroundColor)
                    .opacity(0.7)
                
                
            }
            .padding(.leading, getCustomizedScreenWidth(6))
            
            Spacer()
            
            Text(work.video_playtime)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(foregroundColor)
                .opacity(0.7)
                .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(64))
        .padding(.bottom, getCustomizedScreenWidth(14))
    }
}

struct WorkListItem_Previews: PreviewProvider {
    static var previews: some View {
        WorkListItem(work: Work(), foregroundColor: .black)
    }
}

#else
struct WorkListItem: View {
    var work: Work
    var foregroundColor: Color
    
    var body: some View {
        HStack {
            URLImage(withURL: adminAddress + work.artwork_img_path)
                .frame(width: getCustomizedScreenWidth(64), height: getCustomizedScreenHeight(64))
                .padding(.leading, getCustomizedScreenWidth(16))
            
            VStack(alignment: .leading) {
                Text(work.artwork_title)
                    .font(Font.custom("Arvo", size: 18))
                    .foregroundColor(foregroundColor)
                
                Text("\(work.artwork_artist_nm) | \(work.artwork_location)")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(foregroundColor)
                    .opacity(0.7)
            }
            .padding(.leading, getCustomizedScreenWidth(8))
            
            Spacer()
            
            Text(work.artwork_view_playtime)
                .font(Font.custom("Pretendard", size: 14))
                .foregroundColor(foregroundColor)
                .opacity(0.7)
                .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(64))
        .padding(.bottom, getCustomizedScreenWidth(14))
    }
}

struct WorkListItem_Previews: PreviewProvider {
    static var previews: some View {
        WorkListItem(work: Work(), foregroundColor: .black)
    }
}

#endif
