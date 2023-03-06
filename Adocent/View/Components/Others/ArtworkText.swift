//
//  ArtworkText.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/26.
//

import SwiftUI

struct ArtworkText: View {
    var work: Work
    var seeMore: Bool
    
    var body: some View {
        Text(work.artwork_text)
            .font(Font.custom("Pretendard-Medium", size: 14))
            .lineLimit(seeMore ? nil : 4)
            .foregroundColor(.white)
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(-6))
            .offset(y: getCustomizedScreenHeight(-6))
    }
}

struct ArtworkText_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkText(work: Work(), seeMore: true)
    }
}
