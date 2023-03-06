//
//  WorkTabCommentaryListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/24.
//

import SwiftUI

#if LOCAL_API
struct WorkTabCommentaryListItem: View {
    var docentTour: DocentTour
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: docentTour.image_url)
                .frame(width: getCustomizedScreenWidth(325), height: getCustomizedScreenHeight(168))

            HStack {
                Text(docentTour.title)
                    .font(Font.custom("Pretendard-Bold", size: 26))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(16))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.tour_guide)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
                Text("KRWO")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
            }
            .padding(.top, getCustomizedScreenHeight(135))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .padding(.leading, getCustomizedScreenWidth(16))
    }
}

struct WorkTabCommentaryListItem_Previews: PreviewProvider {
    static var previews: some View {
        WorkTabCommentaryListItem(docentTour: DocentTour())
    }
}
#else
struct WorkTabCommentaryListItem: View {
    var docentTour: DocentTour
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: adminAddress + docentTour.artwork_img_path)
                .frame(width: getCustomizedScreenWidth(325), height: getCustomizedScreenHeight(168))

            HStack {
                Text(docentTour.artwork_title)
                    .font(Font.custom("Pretendard-Bold", size: 26))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(16))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.artwork_title)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
                Text("KRWO")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
            }
            .padding(.top, getCustomizedScreenHeight(135))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .padding(.leading, getCustomizedScreenWidth(16))
    }
}

struct WorkTabCommentaryListItem_Previews: PreviewProvider {
    static var previews: some View {
        WorkTabCommentaryListItem(docentTour: DocentTour())
    }
}
#endif
