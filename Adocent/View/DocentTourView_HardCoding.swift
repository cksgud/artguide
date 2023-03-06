//
//  DocentTourView_HardCoding.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/12.
//

import SwiftUI

struct DocentTourView_HardCoding: View {
    @State var seeMore = false
    @State var disableParentScroll = false
    @State var workList = [Work]()
    @State var selectedLanguage = languages.first!
    var text = """
        AI 도슨트로 변신한 GalleryBK 최민지 부관장님과 함께 작가 나현의 시선을 따라가 봅니다. 객관적 사실과 주관적 시선의 결합으로 이루어진 5개의 대표 프로젝트를 통해, 과거와 현재의 기록이 융합되어 하나의 예술이 되는 순간을 함께 감상해보고자 합니다.
    """
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: false, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    Image("docentTourItemImage")
                        .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(375))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                        .scaleEffect(1.5)
                    
                    // 제목
                    HStack {
                        Text("AI 도슨트가 들려주는\n나현 대표 프로젝트 5선")
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    // 언어 선택 및 정렬
                    HStack {
                        LanguageSortOptionPicker(selectedLanguage: $selectedLanguage, selectedSortOrder: Binding.constant(""), foregroundColor: .white)
                        
                        Spacer()
                        
                        Image("workViewsIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text("5개")
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                        
                        Image("clockIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text("7분")
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(15))
                    
                    // 작품 해설
                    Text(!seeMore ?
                         "\(text.prefix(upTo: text.index(text.startIndex, offsetBy: text.count / 2))) ..."
                         : text)
                        .font(Font.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(.white)
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(-6))
                        .offset(y: getCustomizedScreenHeight(-6))
                    
                    // 더보기
                    if !seeMore {
                        VStack {
                            Text("더보기")
                                .font(Font.custom("Pretendard-Bold", size: 14))
                                .foregroundColor(.customBlue)
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .onTapGesture {
                                    seeMore = true
                                }
                            
                            // 더보기 밑줄
                            Rectangle()
                                .fill(Color.customBlue)
                                .frame(width: getCustomizedScreenWidth(40), height: getCustomizedScreenHeight(1.5))
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .offset(y: getCustomizedScreenHeight(-12))
                        }
                    }
                    
                    WhiteButton(text: "투어 시작하기", width: 350)
                        .padding(.leading, getCustomizedScreenWidth(-14))
                        .padding(.top, getCustomizedScreenHeight(22))
                        .padding(.leading, getCustomizedScreenWidth(16))
                    
                    // 푸터
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

//struct DocentTourView_HardCoding_Previews: PreviewProvider {
//    static var previews: some View {
//        DocentTourView_HardCoding()
//    }
//}
