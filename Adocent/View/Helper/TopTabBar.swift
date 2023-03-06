//
//  TopTabBar.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

struct TopTabBar: View {
    var tabAlignment: TabAlignment
    var textSize: CGFloat
    var firstTabText: String
    var secondTabText: String
    @Binding var tabIndex: Int
    var workCount: Int
    
    var body: some View {
        if tabAlignment == TabAlignment.leading {
            HStack {
                TabBarButton(textSize: textSize, text: firstTabText, isSelected: .constant(tabIndex == 0), workCount: workCount)
                    .onTapGesture {
                        onButtonTapped(index: 0)
                    }
                
                Spacer()
                
                TabBarButton(textSize: textSize, text: secondTabText, isSelected: .constant(tabIndex == 1), workCount: -1)
                    .onTapGesture {
                        onButtonTapped(index: 1)
                    }
                
                Spacer()
            }
            .foregroundColor(.white)
        } else if tabAlignment == TabAlignment.center {
            HStack {
                HStack {
                    Spacer()
                    
                    TabBarButton(textSize: textSize, text: firstTabText, isSelected: .constant(tabIndex == 0), workCount: workCount)
                        .onTapGesture {
                            onButtonTapped(index: 0)
                        }
                        .offset(x: getCustomizedScreenWidth(4))
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    TabBarButton(textSize: textSize, text: secondTabText, isSelected: .constant(tabIndex == 1), workCount: -1)
                        .onTapGesture {
                            onButtonTapped(index: 1)
                        }
                        .offset(x: getCustomizedScreenWidth(-4))
                    
                    Spacer()
                }
            }
            .foregroundColor(.white)
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation {
            tabIndex = index
        }
    }
}

struct TopTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TopTabBar(tabAlignment: TabAlignment.center, textSize: 20, firstTabText: "작품 해설", secondTabText: "전시 소개", tabIndex: .constant(1), workCount: 2)
    }
}
