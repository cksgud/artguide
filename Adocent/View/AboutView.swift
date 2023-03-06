//
//  AboutView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/26.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var modelData: ModelData
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(9)
                
                Image("aboutImageDarken")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(672))
                    .padding(.top, getCustomizedScreenHeight(44))
                
                Image("logo")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: getCustomizedScreenWidth(200), height: getCustomizedScreenHeight(28))
                    .padding(.top, getCustomizedScreenHeight(347))
                HStack {
                    Image("aboutLeftBracket")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: getCustomizedScreenWidth(32), height: getCustomizedScreenHeight(108))
                        .padding(.top, getCustomizedScreenHeight(307))
                        .padding(.leading, getCustomizedScreenWidth(45))
                    
                    Spacer()
                }
                HStack {
                    Spacer()
                    
                    Image("aboutRightBracket")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: getCustomizedScreenWidth(32), height: getCustomizedScreenHeight(108))
                        .padding(.top, getCustomizedScreenHeight(307))
                        .padding(.trailing, getCustomizedScreenWidth(45))
                }
                
                Text("""
                    AI 도슨트와 함께
                    몰입감 높은 전시를 경험하세요.
                    """)
                    .font(Font.custom("Pretendard-Medium", size: 20))
                    .multilineTextAlignment(.center)
                    .lineSpacing(10)
                    .padding(.top, getCustomizedScreenHeight(546))
                    .foregroundColor(.white)
                
                VStack(alignment: .leading) {
                    // 원하던 작품을 쉽게
                    VStack(alignment: .leading) {
                        Text("원하던 작품을 쉽게")
                            .font(Font.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(16))
                        
                        Text("""
                            전시관에서 QR코드와 함께,
                            전시관 밖에서는 언제 어디서나
                            원하는 작품을 만나보세요.
                            """)
                            .font(Font.custom("Pretendard", size: 18))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(5)
                            .padding(.top, getCustomizedScreenHeight(4))
                            .padding(.bottom, getCustomizedScreenHeight(22))
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .padding(.leading, getCustomizedScreenWidth(16))
                        
                        Image("aboutArtworkEasily")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(288))
                    }
                    
                    VStack(alignment: .center) {
                        Text("AI 도슨트가 들려주는")
                            .font(Font.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, getCustomizedScreenHeight(150))
                        Text("작품 해설")
                            .font(Font.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.white)
                        
                        Text("""
                            ADOCENT가 선보이는 디지털 휴먼,
                            AI 도슨트와 함께 몰입감 높은
                            전시를 경험해보세요.
                            """)
                            .font(Font.custom("Pretendard", size: 18))
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.top, getCustomizedScreenHeight(4))
                            .padding(.bottom, getCustomizedScreenHeight(22))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                        Image("aboutDocent")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(412))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("다양한 컨셉의")
                            .font(Font.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, getCustomizedScreenHeight(150))
                            .padding(.leading, getCustomizedScreenWidth(16))
                        Text("도슨트 투어")
                            .font(Font.custom("Pretendard-Bold", size: 32))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(16))
                        Text("큐레이터가 엄선한 작품을 한 곳에 모아\n다양한 컨셉의 전시를 즐길 수 있습니다.")
                            .font(Font.custom("Pretendard", size: 18))
                            .padding(.bottom, getCustomizedScreenHeight(22))
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .padding(.top, getCustomizedScreenHeight(2))
                            .padding(.leading, getCustomizedScreenWidth(16))
                        
                        Image("aboutDocentTour")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(280))
                    }
                    
                    VStack(alignment: .center) {
                        Text("지금 바로")
                            .font(Font.custom("Pretendard-Medium", size: 24))
                            .foregroundColor(.white)
                            .padding(.top, getCustomizedScreenHeight(150))
                            .padding(.leading, getCustomizedScreenWidth(16))
                        Text("ADOCENT를 만나보세요.")
                            .font(Font.custom("Pretendard-Medium", size: 24))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(16))
                        
                        Image("aboutAdocentNow")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(183), height: getCustomizedScreenHeight(198))
                            .padding(.top, getCustomizedScreenHeight(18))
                        
                        NavigationLink {
                            MainView(galleryList: modelData.artGalleryListData, exhibitionList: modelData.artExhibitionListData, workList: modelData.artWorkListData, docentTourList: modelData.artDocentTourListData)
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                        } label: {
                            Text("ADOCENT 시작하기")
                                .font(Font.custom("Arvo-Bold", size: 16))
                                .foregroundColor(.black)
                            .frame(width: getCustomizedScreenWidth(343), height: getCustomizedScreenHeight(56))
                            .background(Color.white)
                        }
                        .padding(.top, getCustomizedScreenHeight(38))
                        .padding(.leading, getCustomizedScreenWidth(16))
                    }
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(38))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(20))
                }
                .padding(.top, getCustomizedScreenHeight(874))
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView {
            
        }
    }
}
