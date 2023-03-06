//
//  ExhibitionListItem.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct ExhibitionListItem: View {
    var exhibition: Exhibition
    
    var body: some View {
        VStack {
            if exhibition.id % 2 == 1 {
                ZStack {
                    URLImage(withURL: exhibition.image_url)
                        .frame(height: getCustomizedScreenHeight(264))
                    
                    HStack {
                        Image("left_bracket_black")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(264))
                        Spacer()
                    }
                }
                .padding(.leading, getCustomizedScreenWidth(16))
            } else {
                ZStack {
                    URLImage(withURL: exhibition.image_url)
                        .frame(height: getCustomizedScreenHeight(264))
                    
                    HStack {
                        Spacer()
                        Image("right_bracket_black")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(264))
                    }
                }
                .padding(.trailing, getCustomizedScreenWidth(16))
            }
            
            VStack {
                HStack {
                    Text("\(exhibition.start_date) - \(exhibition.end_date)")
                        .font(Font.custom("Pretendard", size: 14))
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(10))
                .padding(.bottom, getCustomizedScreenHeight(2))
                
                HStack {
                    Text(exhibition.name)
                        .font(Font.custom("Arvo", size: 24))
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(2))
                
                HStack {
                    Text(exhibition.tags)
                        .font(Font.custom("Pretendard", size: 14))
                    Spacer()
                }
                .offset(y: getCustomizedScreenHeight(6))
            }
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(38))
        }
    }
}

struct ExhibitionListItem_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionListItem(exhibition: Exhibition())
    }
}
#else
struct ExhibitionListItem: View {
    var exhibition: Exhibition
    
    var body: some View {
        VStack {
            if exhibition.exhibition_id % 2 == 1 {
                ZStack {
                    URLImage(withURL: adminAddress + exhibition.exhibition_img_path)
                        .scaledToFill()
                        .frame(height: getCustomizedScreenHeight(264), alignment: .center)
                        .clipped()
                    
                    HStack {
                        Image("left_bracket_black")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(264))
                        Spacer()
                    }
                }
                .padding(.leading, getCustomizedScreenWidth(16))
            } else {
                ZStack {
                    URLImage(withURL: adminAddress + exhibition.exhibition_img_path)
                        .scaledToFill()
                        .frame(height: getCustomizedScreenHeight(264), alignment: .center)
                        .clipped()
                    
                    HStack {
                        Spacer()
                        Image("right_bracket_black")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(264))
                    }
                }
                .padding(.trailing, getCustomizedScreenWidth(16))
            }
            
            VStack {
                HStack {
                    Text("\(exhibition.venue_nm)")
                        .font(Font.custom("Pretendard", size: 14))
                    Text("| \(exhibition.exhibition_start_date) - \(exhibition.exhibition_end_date)")
                        .font(Font.custom("Pretendard", size: 14))
                        .opacity(0.7)
                        .offset(x: getCustomizedScreenWidth(-3))
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(10))
                .padding(.bottom, getCustomizedScreenHeight(2))
                
                HStack {
                    Text(exhibition.exhibition_nm)
                        .font(Font.custom("Arvo", size: 24))
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(2))
                
                HStack {
                    Text(exhibition.exhibition_inline_text)
                        .font(Font.custom("Pretendard", size: 14))
                    Spacer()
                }
                .offset(y: getCustomizedScreenHeight(6))
            }
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(38))
        }
    }
}

struct ExhibitionListItem_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionListItem(exhibition: Exhibition())
    }
}
#endif
