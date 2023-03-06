//
//  TabBarButton.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

struct TabBarButton: View {
    var textSize: CGFloat
    let text: String
    @Binding var isSelected: Bool
    let workCount: Int
    
    var body: some View {
        HStack {
            Text(text)
                .opacity(isSelected ? 1 : 0.3)
                .font(.custom("Pretendard-Bold", size: textSize))
            
            if workCount != -1 {
                Text("\(workCount)")
                    .offset(x: getCustomizedScreenWidth(-6))
                    .offset(y: getCustomizedScreenHeight(-10.5))
                    .font(Font.custom("Arvo", size: textSize))
                    .foregroundColor(.customBlue)
            }
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(textSize: 20, text: "인기 작품해설", isSelected: .constant(true), workCount: 2)
    }
}
