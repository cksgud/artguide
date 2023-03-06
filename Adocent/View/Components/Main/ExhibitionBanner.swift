//
//  ExhibitionBanner.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct ExhibitionBanner: View {
    var exhibition: Exhibition
    var exhibitionListCount: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            URLImage(withURL: exhibition.image_url)
                .scaleEffect(y: 1.1)
                .frame(height: getCustomizedScreenHeight(812))
            
            HStack {
                Image("left_bracket_white")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                    .padding(.leading, getCustomizedScreenWidth(16))
                
                Spacer()
                
                Image("right_bracket_white")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                    .padding(.trailing, getCustomizedScreenWidth(16))
            }
            .padding(.bottom, getCustomizedScreenHeight(304))
            
            HStack {
                Text(exhibition.name)
                    .font(Font.custom("Arvo", size: 36))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, getCustomizedScreenHeight(140))
            .padding(.leading, getCustomizedScreenWidth(16))
            
            HStack {
                Text(exhibition.tags)
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, getCustomizedScreenHeight(103))
            .padding(.leading, getCustomizedScreenWidth(16))
            
            CustomDivider()
                .padding(.bottom, getCustomizedScreenHeight(70))
                .padding(.leading, getCustomizedScreenWidth(16))
        
            HStack {
                Spacer()
                Text("\(exhibition.id)")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                Text("-")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                    .opacity(0.5)
                Text("\(exhibitionListCount)")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                    .opacity(exhibition.id == exhibitionListCount ? 1 : 0.5)
            }
            .padding(.bottom, getCustomizedScreenHeight(24))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
    }
}

struct ExhibitionBanner_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionBanner(exhibition: Exhibition(), exhibitionListCount: 3)
    }
}
#else
struct ExhibitionBanner: View {
    var exhibition: Exhibition
    var exhibitionListCount: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            URLImage(withURL: adminAddress + exhibition.exhibition_img_path)
                .scaleEffect(y: 1.1)
                .frame(height: getCustomizedScreenHeight(812))
            
            HStack {
                Image("left_bracket_white")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                    .padding(.leading, getCustomizedScreenWidth(16))
                
                Spacer()
                
                Image("right_bracket_white")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                    .padding(.trailing, getCustomizedScreenWidth(16))
            }
            .padding(.bottom, getCustomizedScreenHeight(304))
            
            HStack {
                Text(exhibition.exhibition_nm)
                    .font(Font.custom("Arvo", size: 36))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, getCustomizedScreenHeight(140))
            .padding(.leading, getCustomizedScreenWidth(16))
            
            HStack {
                Text(exhibition.venue_nm)
                    .font(Font.custom("Pretendard", size: 18))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.bottom, getCustomizedScreenHeight(103))
            .padding(.leading, getCustomizedScreenWidth(16))
            
            CustomDivider()
                .padding(.bottom, getCustomizedScreenHeight(70))
                .padding(.leading, getCustomizedScreenWidth(16))
        
            HStack {
                Spacer()
                Text("\(exhibition.exhibition_id)")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                Text("-")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                    .opacity(0.5)
                Text("\(exhibitionListCount)")
                    .font(Font.custom("Arvo", size: 24))
                    .foregroundColor(.white)
                    .opacity(exhibition.exhibition_id == exhibitionListCount ? 1 : 0.5)
            }
            .padding(.bottom, getCustomizedScreenHeight(24))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
    }
}

struct ExhibitionBanner_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionBanner(exhibition: Exhibition(), exhibitionListCount: 3)
    }
}
#endif
