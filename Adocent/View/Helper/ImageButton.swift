//
//  ImageButton.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import SwiftUI

struct ImageButton: View {
    var imageName: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Image(imageName)
                .resizable()
                .frame(width: getCustomizedScreenWidth(24), height: getCustomizedScreenHeight(24))
                .padding(.top, getCustomizedScreenHeight(12))
                .padding(.bottom, getCustomizedScreenHeight(12))
                .padding(.leading, getCustomizedScreenWidth(12))
                .padding(.trailing, getCustomizedScreenWidth(12))
                .border(Color.white)
                .padding(.trailing, getCustomizedScreenWidth(-10))
        })
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(imageName: String())
    }
}
