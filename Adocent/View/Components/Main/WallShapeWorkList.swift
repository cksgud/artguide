//
//  WallShapeWorkList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct WallShapeWorkList: View {
    var title: String
    var workList : [Work]
    @State var firstHalf = [Work]()
    @State var secondHalf = [Work]()
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(Font.custom("Pretendard-Medium", size: 32))
                
                Text("\(workList.count)")
                    .offset(x: -getCustomizedScreenWidth(6))
                    .offset(y: -getCustomizedScreenHeight(12.5))
                    .font(Font.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.customBlue)
                
                Spacer()
            }
            .padding(.top, title == "인기 작품 해설" ? getCustomizedScreenHeight(90) : getCustomizedScreenHeight(54 + 92))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(22))
            
            HStack {
                VStack {
                    ForEach(firstHalf) { work in
                        NavigationLink {
                            WorkView(work: work, workList: workList)
                        } label: {
                            WallShapeWorkListItem(work: work)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.leading, getCustomizedScreenWidth(16))
                
                VStack {
                    ForEach(secondHalf) { work in
                        NavigationLink {
                            WorkView(work: work, workList: workList)
                        } label: {
                            WallShapeWorkListItem(work: work)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }.padding(.trailing, getCustomizedScreenWidth(16))
            }
        }
        .onAppear() {
            firstHalf.removeAll()
            secondHalf.removeAll()
            
            for count in 0..<workList.count / 2 {
                firstHalf.append(workList[count])
            }
            for count in workList.count / 2..<workList.count {
                secondHalf.append(workList[count])
            }
        }
    }
}

struct WallShapeWorkList_Previews: PreviewProvider {
    static var previews: some View {
        WallShapeWorkList(title: "인기 작품 해설", workList: [Work]())
    }
}

#else
struct WallShapeWorkList: View {
    var title: String
    var workList : [Work]
    @State var firstHalf = [Work]()
    @State var secondHalf = [Work]()
    @State var firstHalfCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(Font.custom("Arvo", size: 32))
                
                Text("\(workList.count)")
                    .offset(x: getCustomizedScreenWidth(-6))
                    .offset(y: getCustomizedScreenHeight(-12.5))
                    .font(Font.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.customBlue)
                
                Spacer()
            }
            .padding(.top, title == "인기 작품 해설" ? getCustomizedScreenHeight(90) : getCustomizedScreenHeight(54 + 92))
            .padding(.leading, getCustomizedScreenWidth(16))
            .padding(.bottom, getCustomizedScreenHeight(22))
            
            HStack {
                VStack {
                    ForEach(firstHalf, id: \.self.artwork_id) { work in
                        NavigationLink {
                            WorkView(work: work, workList: workList)
                        } label: {
                            WallShapeWorkListItem(work: work)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.leading, getCustomizedScreenWidth(10))
                
                VStack {
                    ForEach(secondHalf, id: \.self.artwork_id) { work in
                        NavigationLink {
                            WorkView(work: work, workList: workList)
                        } label: {
                            WallShapeWorkListItem(work: work)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.trailing, getCustomizedScreenWidth(10))
                .offset(y: firstHalf.count > secondHalf.count ? getCustomizedScreenHeight(-100) : 0)
                .padding(.bottom, firstHalf.count > secondHalf.count ? getCustomizedScreenHeight(-100) : 0)
            }
        }
        .onAppear() {
            firstHalf.removeAll()
            secondHalf.removeAll()
            
            let doubleHalfCount = ceil(Double(workList.count) / 2)
            firstHalfCount = Int(doubleHalfCount)
            
            for count in 0..<firstHalfCount {
                firstHalf.append(workList[count])
            }
            for count in firstHalfCount..<workList.count {
                secondHalf.append(workList[count])
            }
        }
    }
}

struct WallShapeWorkList_Previews: PreviewProvider {
    static var previews: some View {
        WallShapeWorkList(title: "인기 작품 해설", workList: [Work]())
    }
}

#endif
