//
//  WhiteBorderButton.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/20.
//

import SwiftUI

struct WhiteBorderButton: View {
    var text: String
    
    var body: some View {
        Button(action:{
            
        }) {
            Text(text)
                .font(Font.custom("Arvo", size: 14))
                .foregroundColor(.white)
        }
        .border(Color.white)
        .background(Color.black)
    }
}

struct WhiteBorderButton_Previews: PreviewProvider {
    static var previews: some View {
        WhiteBorderButton(text: String())
    }
}
