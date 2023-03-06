//
//  WorkTabCommentaryView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/24.
//

import SwiftUI

struct WorkTabCommentaryView: View {
    var docentTour: DocentTour
    
    var body: some View {
        DocentTourView(docentTour: docentTour)
    }
}

struct WorkTabCommentaryView_Previews: PreviewProvider {
    static var previews: some View {
        WorkTabCommentaryView(docentTour: DocentTour())
    }
}
