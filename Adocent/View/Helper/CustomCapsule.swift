//
//  CustomCapsule.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/08.
//

import SwiftUI

struct CustomCapsule: View {
    var text: String
    var foregroundColor: Color
    var backgroundColor: Color
    
    var body: some View {
        Text(text)
            .foregroundColor(foregroundColor)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .padding()
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .frame(height: getCustomizedScreenHeight(36))
            .background(Capsule().fill(backgroundColor))
    }
}

struct CustomCapsule_Previews: PreviewProvider {
    static var previews: some View {
        CustomCapsule(text: "붉은 색의 의미는?", foregroundColor: .black, backgroundColor: .white)
    }
}
