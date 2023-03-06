//
//  MainView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/09/14.
//

import SwiftUI
import AVKit
import Alamofire
import SDWebImageSwiftUI

#if LOCAL_API
struct MainView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var galleryList: [Gallery]
    @State var exhibitionList: [Exhibition]
    @State var workList: [Work]
    @State var docentTourList: [DocentTour]
    @State var exhibitionBannerPageNumber = 0
    @State var exhibitionBannerPageDirection = UIPageViewController.NavigationDirection.forward
    @State var disableParentScroll = false
    
    var body: some View {
        NavigationView {
            ScrollView(disableParentScroll ? [] : .vertical) {
                if !exhibitionList.isEmpty {
                    ZStack(alignment: .top) {
                        MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                            .zIndex(1)
                        
                        PageView(pages: exhibitionList.map { ExhibitionBanner(exhibition: $0, exhibitionListCount: exhibitionList.count) }, onDemandPage: $exhibitionBannerPageNumber, direction: $exhibitionBannerPageDirection, enableSwipe: true)
                            .aspectRatio(375 / 812, contentMode: .fit)
                    }
                    
                    VStack {
                        ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.MainView)
                        
                        WallShapeWorkList(title: "인기 작품 해설", workList: workList)
                        
                        DocentTourList(docentTourList: docentTourList)
                            .background(
                                CustomBackground(offsetY: 175 + 236 / 2, backgroundColor: Color.black)
                            )
                        
                        GalleryList(galleryList: galleryList)
                        
                    }
                    
                } else {
                    VStack {
                        Text("로딩중.. 잠시 기다려주세요")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .padding(.top, 100)
                    }
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear() {
                if firestoreUserRepository.user.loginId == "" {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        for firestoreUser in firestoreUserRepository.firestoreUsers {
                            if firestoreUser.loginId == UserDefaults.standard.string(forKey: "AppleLoginID") {
                                firestoreUserRepository.user = firestoreUser
                            }
                        }
                    }
                }
                
                bothEndsConnected = true
                
                #if NOSERVER
                    exhibitionList = modelData.exhibitionListData
                    workList = modelData.workListData
                    docentTourList = modelData.docentTourListData
                    galleryList = modelData.galleryListData
                #else
                    if let url = URL(string: exhibitionListAPI) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data {
                                do {
                                    exhibitionList = try JSONDecoder().decode([Exhibition].self, from: data)
                                } catch let error {
                                    print("error = \(error)")
                                }
                            } else {
                                exhibitionList = modelData.exhibitionListData
                            }
                        }.resume()
                    }
                    
                    if let url = URL(string: workListAPI) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data {
                                do {
                                    workList = try JSONDecoder().decode([Work].self, from: data)
                                } catch let error {
                                    print("error = \(error)")
                                }
                            } else {
                                workList = modelData.workListData
                            }
                        }.resume()
                    }
                    
                    if let url = URL(string: docentTourListAPI) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data {
                                do {
                                    docentTourList = try JSONDecoder().decode([DocentTour].self, from: data)
                                } catch let error {
                                    print("error = \(error)")
                                }
                            } else {
                                docentTourList = modelData.docentTourListData
                            }
                        }.resume()
                    }
                    
                    if let url = URL(string: galleryListAPI) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            if let data = data {
                                do {
                                    galleryList = try JSONDecoder().decode([Gallery].self, from: data)
                                } catch let error {
                                    print("error = \(error)")
                                }
                            } else {
                                galleryList = modelData.galleryListData
                            }
                        }.resume()
                    }
                #endif
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(galleryList: [Gallery](), exhibitionList: [Exhibition](), workList: [Work](), docentTourList: [DocentTour]())
            .environmentObject(ModelData())
    }
}

#else
struct MainView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var galleryList: [Gallery]
    @State var exhibitionList: [Exhibition]
    @State var workList: [Work]
    @State var docentTourList: [DocentTour]
    @State var exhibitionBannerPageNumber = 0
    @State var exhibitionBannerPageDirection = UIPageViewController.NavigationDirection.forward
    @State var disableParentScroll = false
    
    var body: some View {
        NavigationView {
            ScrollView(disableParentScroll ? [] : .vertical) {
                ZStack(alignment: .top) {
                    MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                        .zIndex(1)
                    
                    CustomPlayer(urlString: ipAddress + "/static/vod/main_intro.mp4")
                    
                    Text("DIVE INTO FRAME")
                        .font(Font.custom("Arvo", size: 18))
                        .foregroundColor(.white)
                        .padding(.top, getCustomizedScreenHeight(718))
                    
                    Image("chevronIcon")
                        .frame(width: getCustomizedScreenWidth(20), height: getCustomizedScreenHeight(10))
                        .padding(.top, getCustomizedScreenHeight(763))
                }
                
                if !exhibitionList.isEmpty && !workList.isEmpty && !galleryList.isEmpty {
                    VStack {
                        ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.MainView)
                        
                        WallShapeWorkList(title: "인기 작품 해설", workList: workList)
                        
                        DocentTourList(docentTourList: docentTourList)
                            .background(
                                CustomBackground(offsetY: 175 + 236 / 2, backgroundColor: Color.black)
                            )
                        
                        GalleryList(galleryList: galleryList)
                    }
                    .onAppear() {
                        if modelData.artExhibitionListData.isEmpty {
                            modelData.artExhibitionListData = exhibitionList
                            modelData.artWorkListData = workList
                            modelData.artDocentTourListData = docentTourList
                            modelData.artGalleryListData = galleryList
                        }
                    }
                }
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .task {
                exhibitionList = await httpGetPost(urlString: exhibitionListAPI, bodyString: apiBody, parameterString: "")
                workList = await httpGetPost(urlString: workListAPI, bodyString: apiBody, parameterString: "")
                docentTourList = await httpGetPost(urlString: docentTourListAPI, bodyString: apiBody, parameterString: "")
                galleryList = await httpGetPost(urlString: galleryListAPI, bodyString: apiBody, parameterString: "")
                bothEndsConnected = true
                
                let users: [User] = await httpGetPost(urlString: selectAppUserAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? ""))

                if users.isEmpty {
                    var _: [User] = await httpGetPost(urlString: registerAppUserAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&loginType=APPLE")
                }
                
                if firestoreUserRepository.user.loginId == "" {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                        for firestoreUser in firestoreUserRepository.firestoreUsers {
                            if firestoreUser.loginId == UserDefaults.standard.string(forKey: "AppleLoginID") {
                                firestoreUserRepository.user = firestoreUser
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        .accentColor(.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(galleryList: [Gallery](), exhibitionList: [Exhibition](), workList: [Work](), docentTourList: [DocentTour]())
            .environmentObject(ModelData())
    }
}

#endif



























//WebImage(url: URL(string: "https://mvp.adocent.ai/static/images/svg/ico_chevron_24.svg"))
//    .resizable()
//    .frame(width: getCustomizedScreenWidth(20), height: getCustomizedScreenHeight(10))
//    .padding(.top, getCustomizedScreenHeight(763))
