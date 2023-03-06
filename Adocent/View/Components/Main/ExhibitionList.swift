//
//  ExhibitionList.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI

#if LOCAL_API
struct ExhibitionList: View {
    var exhibitionList: [Exhibition]
    var viewName: ViewName
    @State var disableParentScroll = false
    
    var body: some View {
        VStack {
            if viewName == ViewName.MainView {
                HStack {
                    Text("진행중인 전시")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                    
                    NavigationLink {
                        ScrollView(disableParentScroll ? [] : .vertical) {
                            ZStack(alignment: .top) {
                                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                                    .zIndex(1)
                                ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.ExhibitionsMenuView)
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .edgesIgnoringSafeArea(.all)
                        
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(26), height: getCustomizedScreenHeight(20))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, getCustomizedScreenHeight(54))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
            } else if viewName == ViewName.GalleryView {
                HStack {
                    Text("진행중인 전시")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: -getCustomizedScreenWidth(6))
                        .offset(y: -getCustomizedScreenHeight(12.5))
                        .font(Font.custom("Arvo", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(54))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
            } else if viewName == ViewName.ExhibitionsMenuView {
                HStack {
                    Text("전시회")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                        .foregroundColor(.black)
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Arvo", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(54 + 92))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
            }
            
            ForEach(exhibitionList) { exhibition in
                NavigationLink {
                    ExhibitionView(exhibition: exhibition)
                } label: {
                    ExhibitionListItem(exhibition: exhibition)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ExhibitionList_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionList(exhibitionList: [Exhibition](), viewName: ViewName.MainView)
    }
}
#else
struct ExhibitionList: View {
    var exhibitionList: [Exhibition]
    var viewName: ViewName
    @State var disableParentScroll = false
    
    var body: some View {
        VStack {
            if viewName == ViewName.MainView {
                HStack {
                    Text("진행중인 전시")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                    
                    NavigationLink {
                        ScrollView(disableParentScroll ? [] : .vertical) {
                            ZStack(alignment: .top) {
                                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                                    .zIndex(1)
                                ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.ExhibitionsMenuView)
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                        .edgesIgnoringSafeArea(.all)
                        
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(26), height: getCustomizedScreenHeight(20))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, getCustomizedScreenHeight(54))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
                
                ForEach(exhibitionList, id: \.self.exhibition_id) { exhibition in
                    NavigationLink {
                        ExhibitionView(exhibition: exhibition)
                    } label: {
                        ExhibitionListItem(exhibition: exhibition)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } else if viewName == ViewName.GalleryView {
                HStack {
                    Text("진행중인 전시")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Arvo", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(54))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
                
                ForEach(exhibitionList, id: \.self.exhibition_id) { exhibition in
                    NavigationLink {
                        ExhibitionView(exhibition: exhibition)
                    } label: {
                        ExhibitionListItem(exhibition: exhibition)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                Footer(foregroundColor: .black)
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .zIndex(9)
            } else if viewName == ViewName.ExhibitionsMenuView {
                HStack {
                    Text("전시회")
                        .font(Font.custom("Pretendard-Medium", size: 32))
                        .foregroundColor(.black)
                    
                    Text("\(exhibitionList.count)")
                        .offset(x: getCustomizedScreenWidth(-6))
                        .offset(y: getCustomizedScreenHeight(-12.5))
                        .font(Font.custom("Arvo", size: 20))
                        .foregroundColor(.customBlue)
                    
                    Spacer()
                }
                .padding(.top, getCustomizedScreenHeight(54 + 92))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
                
                ForEach(exhibitionList, id: \.self.exhibition_id) { exhibition in
                    NavigationLink {
                        ExhibitionView(exhibition: exhibition)
                    } label: {
                        ExhibitionListItem(exhibition: exhibition)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                Footer(foregroundColor: .black)
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    .zIndex(9)
            }
        }
    }
}

struct ExhibitionList_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionList(exhibitionList: [Exhibition](), viewName: ViewName.MainView)
    }
}
#endif
