//
//  GalleryList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/20.
//

import SwiftUI

struct GalleryList: View {
    var galleryList: [Gallery]
    @State var firstHalf = [Gallery]()
    @State var secondHalf = [Gallery]()
    
    var body: some View {
        VStack {
            HStack {
                Text("지금 adocent 서비스를 이용해보세요")
                    .foregroundColor(.white)
                    .font(Font.custom("Pretendard-Medium", size: 32))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(37))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    ForEach(galleryList, id:\.self.venue_id) { gallery in
                        NavigationLink {
                            GalleryView(gallery: gallery)
                        } label: {
                            GalleryListItem(galleryName: gallery.venue_nm)
                                .offset(x: -getCustomizedScreenWidth(10))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, getCustomizedScreenHeight(3))
                    }
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.leading, getCustomizedScreenWidth(26))
            .padding(.bottom, getCustomizedScreenHeight(54))
            
            Footer(foregroundColor: .white)
                .padding(.leading, getCustomizedScreenWidth(16))
                .offset(y: getCustomizedScreenHeight(-140))
            
            Spacer()
        }
        .background(Color.black)
        .frame(height: getCustomizedScreenHeight(559 - 236 / 2))
        .padding(.top, getCustomizedScreenHeight(90))
        .padding(.bottom, getCustomizedScreenHeight(-140))
        .onAppear() {
            firstHalf.removeAll()
            secondHalf.removeAll()
            
            for count in 0..<galleryList.count / 2 {
                firstHalf.append(galleryList[count])
            }
            for count in galleryList.count / 2..<galleryList.count {
                secondHalf.append(galleryList[count])
            }
        }
    }
}

struct GalleryList_Previews: PreviewProvider {
    static var previews: some View {
        GalleryList(galleryList: [Gallery]())
    }
}
