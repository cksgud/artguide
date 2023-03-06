//
//  EmailGuideView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/13.
//

import SwiftUI

struct EmailGuideView: View {
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("이메일 무단수집거부")
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    Text("""
CJ올리브네트웍스㈜ 홈페이지에 게시된 이메일 주소가 전자우편수집 프로그램이나 그 밖에 기술적 장치를 이용해 무단으로 수집되는 것을 거부합니다. 이를 위반 시『정보통신망 이용촉진 및 정보보호 등에 관한 법률』에 의거 형사 처벌 받게 됨을 유념하시기 바랍니다.
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

//struct EmailGuideView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmailGuideView()
//    }
//}
