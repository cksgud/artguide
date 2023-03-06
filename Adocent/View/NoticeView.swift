//
//  NoticeView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/28.
//

import SwiftUI

struct NoticeView: View {
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("공지사항")
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    Text("""
현재 앱 버전은 MVP 버전입니다.
""")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    Spacer()
                    
                    // 푸터
                    Footer(foregroundColor: .black)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.bottom, getCustomizedScreenHeight(20))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                }
                .padding(.top, getCustomizedScreenHeight(54 + 92))
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

//struct NoticeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoticeView()
//    }
//}
