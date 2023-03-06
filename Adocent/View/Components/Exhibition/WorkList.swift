//
//  WorkList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

#if LOCAL_API
struct WorkList: View {
    var workList: [Work]
    var foregroundColor: Color
    
    var body: some View {
        VStack {
            ForEach(workList) { work in
                NavigationLink {
                    WorkView(work: work, workList: workList)
                } label: {
                    WorkListItem(work: work, foregroundColor: foregroundColor)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct WorkList_Previews: PreviewProvider {
    static var previews: some View {
        WorkList(workList: [Work](), foregroundColor: .black)
    }
}

#else
struct WorkList: View {
    var workList: [Work]
    var foregroundColor: Color
    
    var body: some View {
        VStack {
            ForEach(workList, id: \.self.artwork_id) { work in
                NavigationLink {
                    WorkView(work: work, workList: workList)
                } label: {
                    WorkListItem(work: work, foregroundColor: foregroundColor)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct WorkList_Previews: PreviewProvider {
    static var previews: some View {
        WorkList(workList: [Work](), foregroundColor: .black)
    }
}

#endif
