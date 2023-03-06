//
//  WorkTabCommentaryList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/24.
//

import SwiftUI

#if LOCAL_API
struct WorkTabCommentaryList: View {
    var docentTourList: [DocentTour]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(docentTourList) { docentTour in
                    NavigationLink {
                        WorkTabCommentaryView(docentTour: docentTour)
                    } label: {
                        WorkTabCommentaryListItem(docentTour: docentTour)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct WorkTabCommentaryList_Previews: PreviewProvider {
    static var previews: some View {
        WorkTabCommentaryList(docentTourList: [DocentTour]())
    }
}
#else
struct WorkTabCommentaryList: View {
    var docentTourList: [DocentTour]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 0) {
                if docentTourList.count < 4 {
                    DocentTourItem_HardCoding()
                } else {
                    DocentTourListItem(docentTour: docentTourList[3])
                }
            }
        }
    }
}

struct WorkTabCommentaryList_Previews: PreviewProvider {
    static var previews: some View {
        WorkTabCommentaryList(docentTourList: [DocentTour]())
    }
}
#endif
