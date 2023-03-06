//
//  LawGuideView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/13.
//

import SwiftUI

struct LawGuideView: View {
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("법적고지")
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.black)
                        
                        Spacer()
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    Text("""
본 사이트(http://www.cjolivenetworks.co.kr)를 방문해주셔서 감사합니다. CJ그룹의 계열사인 CJ올리브네트웍스㈜(이하 “회사”)는 본 사이트를 방문하는 모든 방문자(이하 “이용자”)에게 적용될 웹사이트 사용 약관 및 조건을 아래와 같이 고지하고, 이용자가 본 약관 및 조건에 동의한다는 조건 하에 본 사이트를 이용자에게 제공하고 있습니다. 따라서 귀하가 본 사이트를 사용 시 아래 약관 및 조건에 동의하는 것으로 간주됨을 사전에 유의하시기 바랍니다.
""")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(48))
                    
                    Text("사이트 이용 제한")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                    Text("""
본 사이트 상의 내용은 오직 개인적∙비상업적 목적(이하 "제한 용도")에 한해 다운로드 및 사용이 가능합니다. 또한, 회사의 사전 서면 동의 없이 제한 용도를 벗어난 수정, 복제, 배포, 전송, 방송 등의 사용은 엄격히 금지됩니다. 본 사이트를 접속하고 사용하는 모든 이용자는 본 법적고지를 준수해야 합니다.
""")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(48))
                    
                    Text("지적재산권")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                    Text("""
본 사이트는 회사가 독점 소유 운영하고 있습니다. 본 사이트에 소개된 모든 등록상표(상표, 상호, 제품 및 서비스명 등) 및 정보자산(문자, 그림, 음성, 파일, 링크, 소스코드 등)은 대한민국을 포함한 전 세계 모든 국가에서 법률에 의거 보호되며 회사는 지적재산권의 불법사용 및 위작 등에 대해 법적 조치를 취할 권리를 보유하고 있습니다. 이용자는 회사의 기업정보, 제품 및 서비스를 확인하고 열람하기 위한 목적 외에 기타 다른 목적으로 자료를 사용하고자 하는 경우 반드시 회사로부터 서면동의를 받아야 합니다.
""")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(48))
                    
                    Text("사이트내용 및 관련 책임소재")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                    Text("""
회사는 본 사이트 및 기타 관련 사이트의 모든 정보에 대한 정확도, 완성도, 신뢰도를 보증하거나 그에 대한 책임을 지지 않습니다. 또한 웹사이트 상의 모든 정보에 대한 판매 목적상의 무제한 보증이나 특별한 목적 하에 맞춰진 어떤 또는 모든 보증을 부인합니다. 따라서 회사에서 문서로 특별히 조언을 드리는 경우를 제외하고는 본 사이트의 정보를 이익과 관련된 결정상의 참고자료로 활용하지 마시기 바랍니다.
더불어 본 사이트 접속 및 사용 혹은 사용불가로 인하거나 본 사이트에서 제공되는 정보와 관련해 발생할 수 있는 일체의 직접적, 간접적, 우발적, 징벌적 또는 필연적 피해에 대해서도 회사는 책임을 지지 않습니다. 본 사이트에 접속하고 사용하는 것과 관련한 제반 책임은 전적으로 이용자 본인에게 있습니다.
""")
                    .multilineTextAlignment(.leading)
                    .font(Font.custom("Pretendard", size: 14))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    Spacer()
                    
                    Footer(foregroundColor: .black)
                        .padding(.top, getCustomizedScreenHeight(80))
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

//struct LawGuideView_Previews: PreviewProvider {
//    static var previews: some View {
//        LawGuideView()
//    }
//}
