//
//  DocentTourWorkList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/08.
//

import SwiftUI

#if LOCAL_API
struct DocentTourWorkList: View {
    var workList: [Work]
    var foregroundColor: Color
    
    var body: some View {
        VStack {
            ForEach(workList) { work in
                NavigationLink {
                    DocentTourDetailView(work: work, workList: workList)
                } label: {
                    WorkListItem(work: work, foregroundColor: foregroundColor)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct DocentTourWorkList_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourWorkList(workList: [Work](), foregroundColor: .black)
    }
}

#else
struct DocentTourWorkList: View {
    var workList: [Work]
    var foregroundColor: Color
    
    var body: some View {
        VStack {
            ForEach(workList, id: \.self.artwork_id) { work in
                NavigationLink {
                    DocentTourDetailView(work: work, workList: workList)
                } label: {
                    WorkListItem(work: work, foregroundColor: foregroundColor)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct DocentTourWorkList_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourWorkList(workList: [Work](), foregroundColor: .black)
    }
}
#endif
