//
//  DocentTourMenuView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/12/13.
//

import SwiftUI

struct DocentTourMenuView: View {
    @EnvironmentObject var modelData: ModelData
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("도슨트 투어")
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.black)
                        
                        Text("1")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-12.5))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    if modelData.artDocentTourListData.count < 4 {
                        DocentTourItem_HardCoding()
                            .padding(.trailing, getCustomizedScreenWidth(16))
                            .offset(x: getCustomizedScreenWidth(-7))
                    } else {
                        DocentTourListItem(docentTour: modelData.artDocentTourListData[3])
                            .padding(.trailing, getCustomizedScreenWidth(16))
                            .offset(x: getCustomizedScreenWidth(-7))
                    }
                    
                    Spacer()
                    
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
