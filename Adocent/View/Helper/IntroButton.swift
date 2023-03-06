//
//  IntroButton.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/11.
//

import SwiftUI

struct IntroButton: View {
    var buttonText: String
    
    var body: some View {
        Text(buttonText)
            .font(.title)
            .foregroundColor(.black)
        .frame(width: 250, height: 40)
        .padding(.all)
        .cornerRadius(17)
        .overlay(
            RoundedRectangle(cornerRadius: 17)
                .stroke(Color.black, lineWidth: 1)
        )
        .opacity(0.5)
    }
}

struct IntroButton_Previews: PreviewProvider {
    static var previews: some View {
        IntroButton(buttonText: "로그인")
    }
}
