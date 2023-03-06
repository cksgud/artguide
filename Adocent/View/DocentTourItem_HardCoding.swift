//
//  DocentTourItem_HardCoding.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/12.
//

import SwiftUI

struct DocentTourItem_HardCoding: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("docentTourItemImage")
                .frame(width: getCustomizedScreenWidth(325), height: getCustomizedScreenHeight(236))

            HStack {
                Text("AI 도슨트가 들려주는 \n나현 대표 프로젝트 5선")
                    .font(Font.custom("Pretendard-Bold", size: 20))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(16))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text("나현의 '다큐멘터리 아트 프로젝트'를 만나보세요.")
                    .font(Font.custom("Pretendard", size: 14))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.top, getCustomizedScreenHeight(76))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.trailing, getCustomizedScreenWidth(16))
            
            HStack {
                Text("해설 5개, 총 7분")
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

struct DocentTourItem_HardCoding_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourItem_HardCoding()
    }
}
