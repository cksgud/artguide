//
//  CustomDivider.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.white)
                .opacity(0.3)
                .frame(width: getCustomizedScreenWidth(343), height: getCustomizedScreenHeight(1))
        }
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
