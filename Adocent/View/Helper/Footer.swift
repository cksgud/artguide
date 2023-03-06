//
//  Footer.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/25.
//

import SwiftUI

#if LOCAL_API
struct Footer: View {
    var foregroundColor: Color
    
    var body: some View {
        HStack {
            Text("© CJ OLIVENETWORKS. All Rights Reserved.\n이메일주소 무단수집 거부 법적고지")
                .font(Font.custom("Pretendard", size: 12))
                .foregroundColor(foregroundColor)
                .opacity(0.5)
            Spacer()
        }
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer(foregroundColor: .white)
    }
}
#else
struct Footer: View {
    var foregroundColor: Color
    
    var body: some View {
        VStack {
            HStack {
                Text("© ADOCENT. All Rights Reserved.")
                    .font(Font.custom("Pretendard", size: 12))
                    .foregroundColor(foregroundColor)
                    .opacity(0.5)
                Spacer()
            }
            
            HStack {
                NavigationLink {
                    EmailGuideView {}
                } label: {
                    Text("이메일주소 무단수집 거부")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(foregroundColor)
                        .opacity(0.5)
                }
                
                NavigationLink {
                    LawGuideView {}
                } label: {
                    Text("법적고지")
                        .font(Font.custom("Pretendard", size: 12))
                        .foregroundColor(foregroundColor)
                        .opacity(0.5)
                }
                
                Spacer()
            }
        }
        .padding(.bottom, getCustomizedScreenHeight(10))
    }
}

struct Footer_Previews: PreviewProvider {
    static var previews: some View {
        Footer(foregroundColor: .white)
    }
}
#endif
