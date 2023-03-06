//
//  DocentTourListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct DocentTourListItem: View {
    var docentTour: DocentTour
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: docentTour.image_url)
                .frame(width: getCustomizedScreenWidth(325), height: getCustomizedScreenHeight(236))

            HStack {
                Text(docentTour.title)
                    .font(Font.custom("Pretendard-Bold", size: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(16))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.commentary)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(52))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.tour_guide)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(203))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .padding(.leading, getCustomizedScreenWidth(16))
    }
}

struct DocentTourListItem_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourListItem(docentTour: DocentTour())
    }
}
#else
struct DocentTourListItem: View {
    @State var docentTour: DocentTour
    
    var body: some View {
        ZStack(alignment: .top) {
            URLImage(withURL: adminAddress + docentTour.artwork_img_path)
                .frame(width: getCustomizedScreenWidth(325), height: getCustomizedScreenHeight(236))

            HStack {
                Text(docentTour.exhibition_img_alt)
                    .font(Font.custom("Pretendard-Bold", size: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(16))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.artwork_img_alt)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(76))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text(docentTour.artwork_size)
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(203))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
        .padding(.leading, getCustomizedScreenWidth(16))
        .onAppear() {
            docentTour.exhibition_img_alt = "AI 도슨트가 들려주는\n나현 대표 프로젝트 5선"
            docentTour.artwork_img_alt = "\n나현의 '다큐멘터리 아트 프로젝트'를 만나보세요."
            docentTour.artwork_size = "해설 5개, 총 7분"
        }
    }
}

struct DocentTourListItem_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourListItem(docentTour: DocentTour())
    }
}
#endif
