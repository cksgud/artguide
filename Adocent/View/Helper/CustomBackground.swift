//
//  CustomBackground.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/20.
//

import SwiftUI

struct CustomBackground: View {
    var offsetY: Float
    var backgroundColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
            }
            Spacer()
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .offset(y: getCustomizedScreenHeight(offsetY))
    }
}

struct CustomBackground_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackground(offsetY: Float(), backgroundColor: Color.black)
    }
}
