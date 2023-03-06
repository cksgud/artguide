//
//  DocentTourList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct DocentTourList: View {
    var docentTourList: [DocentTour]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("도슨트투어")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                    
                    Text("\(docentTourList.count)")
                        .offset(x: -getCustomizedScreenWidth(6))
                        .offset(y: -getCustomizedScreenHeight(12.5))
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                
                HStack {
                    Text("버추얼 휴먼 a의 테마별 작품 해설")
                        .font(Font.custom("Pretendard", size: 16))
                    
                    Spacer()
                }
                
            }
            .padding(.top, getCustomizedScreenHeight(90))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(22))
            
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(docentTourList) { docentTour in
                        NavigationLink {
                            DocentTourView(docentTour: docentTour)
                        } label: {
                            DocentTourListItem(docentTour: docentTour)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
    }
}

struct DocentTourList_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourList(docentTourList: [DocentTour]())
    }
}
#else
struct DocentTourList: View {
    var docentTourList: [DocentTour]
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("도슨트 투어")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                    
                    Text("1")//\(docentTourList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Arvo", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                
                HStack {
                    Text("AI 버추얼 휴먼의 테마별 작품 해설")
                        .font(Font.custom("Pretendard", size: 16))
                    
                    Spacer()
                }
            }
            .padding(.top, getCustomizedScreenHeight(90))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(22))
            
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    if docentTourList.count < 4 {
                        DocentTourItem_HardCoding()
                    } else {
                        DocentTourListItem(docentTour: docentTourList[3])
                    }
                }
            }
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
    }
}

struct DocentTourList_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourList(docentTourList: [DocentTour]())
    }
}
#endif
