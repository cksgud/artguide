//
//  GNBMenuView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/26.
//

import SwiftUI

#if LOCAL_API
struct GNBMenuView: View {
    @EnvironmentObject var modelData: ModelData
    let isOpen: Bool
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                ScrollView(disableParentScroll ? [] : .vertical) {
                    ZStack(alignment: .top) {
                        MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                            .zIndex(1)
                        ExhibitionList(exhibitionList: modelData.exhibitionListData, viewName: ViewName.ExhibitionsMenuView)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                
            } label: {
                Text("전시회")
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                ScrollView(disableParentScroll ? [] : .vertical) {
                    ZStack(alignment: .top) {
                        MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                            .zIndex(1)
                        WallShapeWorkList(title: "작품 해설", workList: modelData.workListData)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                
            } label: {
                Text("작품 해설")
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                DocentNoteView(userDocentNoteList: [UserDocentNote](), menuClose: menuClose)
            } label: {
                Text("도슨트노트")
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                Text("도슨트투어 준비중입니다")
                    .font(Font.custom("Pretendard-Medium", size: 20))
                    .foregroundColor(.black)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
                Text("도슨트투어")
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                NoticeView()
            } label: {
                Text("공지사항")
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            Spacer()
            
            Footer(foregroundColor: .white)
            
        }
        .font(Font.custom("Pretendard-Medium", size: 32))
        .foregroundColor(.white)
        .padding(.top, getCustomizedScreenHeight(108))
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        .padding(.bottom, getCustomizedScreenHeight(48))
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.isOpen ? 0 : getCustomizedScreenWidth(375))
        .frame(height: getCustomizedScreenHeight(812))
        .padding(.bottom, getCustomizedScreenHeight(-176))
        .animation(.default)
    }
}

struct GNBMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GNBMenuView(isOpen: false, menuClose: {
            
        })
        .environmentObject(ModelData())
    }
}

#else
struct GNBMenuView: View {
    @EnvironmentObject var modelData: ModelData
    let isOpen: Bool
    let menuClose: () -> Void
    @State var disableParentScroll = false
    @State var docentTour = DocentTour()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink {
                AboutView(menuClose: menuClose)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } label: {
                Text("About")
                    .padding(.bottom, getCustomizedScreenHeight(10))
                    .font(Font.custom("Arvo-Italic", size: 32))
                    .foregroundColor(.white)
            }
            
            NavigationLink {
                ScrollView(disableParentScroll ? [] : .vertical) {
                    ZStack(alignment: .top) {
                        MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                            .zIndex(1)
                        ExhibitionList(exhibitionList: modelData.artExhibitionListData, viewName: ViewName.ExhibitionsMenuView)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
            } label: {
                Text("전시회")
                    .font(Font.custom("Pretendard-Medium", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                ScrollView(disableParentScroll ? [] : .vertical) {
                    ZStack(alignment: .top) {
                        MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                            .zIndex(1)
                        
                        VStack {
                            WallShapeWorkList(title: "작품 해설", workList: modelData.artWorkListData)
                            
                            Spacer()
                            
                            Footer(foregroundColor: .black)
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .padding(.trailing, getCustomizedScreenWidth(16))
                                .padding(.bottom, getCustomizedScreenHeight(22))
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
                
            } label: {
                Text("AI 작품 해설")
                    .font(Font.custom("Arvo", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                DocentTourMenuView(menuClose: menuClose)
            } label: {
                Text("도슨트 투어")
                    .font(Font.custom("Pretendard-Medium", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                DocentNoteView(userDocentNoteList: [UserDocentNote](), menuClose: menuClose)
            } label: {
                Text("도슨트 노트")
                    .font(Font.custom("Pretendard-Medium", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            NavigationLink {
                NoticeView(menuClose: menuClose)
            } label: {
                Text("공지사항")
                    .font(Font.custom("Pretendard-Medium", size: 32))
                    .foregroundColor(.white)
                    .padding(.bottom, getCustomizedScreenHeight(10))
            }
            
            Spacer()
            
            Footer(foregroundColor: .white)
                .hidden()
        }
        .font(Font.custom("Pretendard-Medium", size: 32))
        .foregroundColor(.white)
        .padding(.top, getCustomizedScreenHeight(108))
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        .padding(.bottom, getCustomizedScreenHeight(48))
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.isOpen ? 0 : getCustomizedScreenWidth(375))
        .frame(height: getCustomizedScreenHeight(812))
        .padding(.bottom, getCustomizedScreenHeight(-176))
        .animation(.default)
    }
}

//struct GNBMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        GNBMenuView(isOpen: false, menuClose: {
//
//        })
//        .environmentObject(ModelData())
//    }
//}

#endif
