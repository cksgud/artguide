//
//  TagBox.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import SwiftUI

struct TagBox: View {
    var tag: String
    var foregroundColor: Color
    
    var body: some View {
        Text("#\(tag)")
            .font(Font.custom("Pretendard-Medium", size: 14))
            .foregroundColor(foregroundColor)
            .padding(.top, getCustomizedScreenHeight(10))
            .padding(.bottom, getCustomizedScreenHeight(10))
            .padding(.leading, getCustomizedScreenWidth(18))
            .padding(.trailing, getCustomizedScreenWidth(18))
            .border(foregroundColor.opacity(0.5))
            .padding(.trailing, getCustomizedScreenWidth(-10))
    }
}

struct TagBox_Previews: PreviewProvider {
    static var previews: some View {
        TagBox(tag: "태그", foregroundColor: .black)
    }
}
