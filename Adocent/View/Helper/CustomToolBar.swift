//
//  CustomToolBar.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI

struct CustomToolBar: View {
    var foregroundColor: Color
    
    var body: some View {
        if #available(iOS 15, *) {
            ZStack(alignment: .top) {
               HStack {
                    Spacer()
                    Image("searchIcon")
                       .renderingMode(.template)
                       .foregroundColor(foregroundColor)
                        .onTapGesture {
                            print("search tapped")
                        }
                }
                .padding(.trailing, getCustomizedScreenWidth(60))
                
                HStack {
                    Spacer()
                    Image("menu")
                        .renderingMode(.template)
                        .foregroundColor(foregroundColor)
                        .onTapGesture {
                            print("menu tapped")
                        }
                }
                .padding(.trailing, getCustomizedScreenWidth(8))
            }
        } else {
            HStack {
                Image("searchIcon")
                   .renderingMode(.template)
                   .foregroundColor(foregroundColor)
                   .onTapGesture {
                        print("search tapped")
                    }
                   .padding(.trailing, getCustomizedScreenWidth(16))
                 
                Image("menu")
                    .renderingMode(.template)
                    .foregroundColor(foregroundColor)
                    .onTapGesture {
                        print("menu tapped")
                    }
            }
            .offset(x: getCustomizedScreenWidth(134))
            .offset(y: getCustomizedScreenHeight(5))
        }
    }
}

struct CustomToolBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolBar(foregroundColor: Color.black)
    }
}
