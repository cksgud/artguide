//
//  WhiteButton.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import SwiftUI

struct WhiteButton: View {
    var text: String
    var width: Float
    
    var body: some View {
        Text(text)
            .font(Font.custom("Pretendard-Medium", size: 16))
            .foregroundColor(.black)
        .frame(width: getCustomizedScreenWidth(width), height: getCustomizedScreenHeight(48))
        .background(Color.white)
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
    }
}

struct WhiteButton_Previews: PreviewProvider {
    static var previews: some View {
        WhiteButton(text: String(), width: Float())
    }
}
