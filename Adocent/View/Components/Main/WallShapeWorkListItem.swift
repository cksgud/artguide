//
//  WallShapeWorkListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct WallShapeWorkListItem: View {
    var work: Work
    
    var body: some View {
        VStack {
            URLImage(withURL: work.image_url)
                .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
                .frame(width: getCustomizedScreenWidth(165))

            HStack {
                Text(work.name)
                    .font(Font.custom("Pretendard-Medium", size: 18))
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(2))
            
            HStack {
                Text("Beyond Horizon")
                    .font(Font.custom("Pretendard", size: 14))
                Spacer()
            }
        }
        .padding(.bottom, getCustomizedScreenHeight(22))
    }
}

struct WallShapeWorkListItem_Previews: PreviewProvider {
    static var previews: some View {
        WallShapeWorkListItem(work: Work())
    }
}

#else
struct WallShapeWorkListItem: View {
    var work: Work
    
    var body: some View {
        VStack {
            URLImage(withURL: adminAddress + work.artwork_img_path)
                .aspectRatio(CGSize(width: 1.0, height: 1.0), contentMode: .fit)
                .frame(width: getCustomizedScreenWidth(165))

            HStack {
                Text(work.artwork_title)
                    .font(Font.custom("Arvo", size: 18))
                Spacer()
            }
            .padding(.leading, getCustomizedScreenWidth(5))
            .padding(.top, getCustomizedScreenHeight(2))
            
            HStack {
                Text(work.artwork_artist_nm)
                    .font(Font.custom("Pretendard", size: 14))
                    .opacity(0.7)
                Spacer()
            }
            .padding(.leading, getCustomizedScreenWidth(5))
            
            HStack {
                Text(work.artwork_date)
                    .font(Font.custom("Pretendard", size: 14))
                    .opacity(0.7)
                Spacer()
            }
            .padding(.leading, getCustomizedScreenWidth(5))
        }
        .padding(.bottom, getCustomizedScreenHeight(22))
    }
}

struct WallShapeWorkListItem_Previews: PreviewProvider {
    static var previews: some View {
        WallShapeWorkListItem(work: Work())
    }
}

#endif
