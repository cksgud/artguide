//
//  PrevNextButtons.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/09.
//

import SwiftUI

struct PrevNextButtons: View {
    var workList: [Work]
    @Binding var workIndex: Int
    var viewName: ViewName
    
    var body: some View {
        HStack {
            NavigationLink {
                if viewName == ViewName.WorkView {
                    WorkView(work: workList[workIndex], workList: workList)
                }
                else if viewName == ViewName.DocentTourDetailView {
                    DocentTourDetailView(work: workList[workIndex], workList: workList)
                }
            } label: {
                if workIndex >= 1 {
                    HStack {
                        Image("previousArrow")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(14))
                            .foregroundColor(.customWhite)
                        
                        Text("이전")
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                    }
                } else {
                    EmptyView()
                }
            }
            .simultaneousGesture(TapGesture().onEnded({
                if workIndex >= 1 {
                    workIndex -= 1
                }
            }))
            .disabled(workIndex < 1 ? true : false)
            
            Spacer()
            
            NavigationLink {
                if viewName == ViewName.WorkView {
                    WorkView(work: workList[workIndex], workList: workList)
                }
                else if viewName == ViewName.DocentTourDetailView {
                    DocentTourDetailView(work: workList[workIndex], workList: workList)
                }
            } label: {
                if workIndex < workList.count - 1 {
                    HStack {
                        Text("다음")
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                        
                        Image("nextArrow")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(14))
                            .foregroundColor(.white)
                    }
                } else {
                    EmptyView()
                }
            }
            .simultaneousGesture(TapGesture().onEnded({
                if workIndex < workList.count - 1 {
                    workIndex += 1
                }
            }))
            .disabled(workIndex >= workList.count - 1 ? true : false)
        }
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        .padding(.bottom, getCustomizedScreenHeight(38))
    }
}

//struct PrevNextButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        PrevNextButtons(workList: [Work](), workIndex: 0)
//    }
//}
