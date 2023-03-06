//
//  WorkTab.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

struct WorkTab: View {
    @State var selectedLanguage = languages.first!
    @State var selectedSortOrder = sortOrder.first!
    var docentTourList: [DocentTour]
    var workList: [Work]
    
    var body: some View {
        WorkTabCommentaryList(docentTourList: docentTourList)
            .padding(.trailing, getCustomizedScreenWidth(16))
        
        HStack {
            Text("전시 내 작품 해설")
                .font(Font.custom("Pretendard-Bold", size: 24))
                .foregroundColor(.white)
            
            Spacer()
            
            if selectedSortOrder != "" {
                Menu {
                    Picker(selection: $selectedSortOrder, label: EmptyView()) {
                        ForEach(sortOrder, id: \.self) {
                            Text($0)
                        }
                    }
                } label: {
                    Image("sortIcon")
                        .resizable()
                        .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.top, getCustomizedScreenHeight(38))
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        
        if selectedSortOrder == "추천" {
            WorkList(workList: workList, foregroundColor: .white)
                .padding(.top, getCustomizedScreenWidth(22))
        } else if selectedSortOrder == "작품명" {
            WorkList(workList: workList.sorted(by: >), foregroundColor: .white)
                .padding(.top, getCustomizedScreenWidth(22))
        }
    }
}

struct WorkTab_Previews: PreviewProvider {
    static var previews: some View {
        WorkTab(docentTourList: [DocentTour](), workList: [Work]())
    }
}
