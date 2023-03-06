//
//  GalleryView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/20.
//

import SwiftUI

#if LOCAL_API
struct GalleryView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var gallery: Gallery
    @State var exhibitionList = [Exhibition]()
    @State var galleryBannerList = [GalleryBanner]()
    @State var galleryBannerPageNumber = 0
    @State var galleryBannerPageDirection = UIPageViewController.NavigationDirection.forward
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack {
                    CustomBackground(offsetY: 0, backgroundColor: Color.customBlue)
                        .frame(height: getCustomizedScreenHeight(278))
                        .padding(.top, getCustomizedScreenHeight(110))
                    
                    VStack {
                        HStack {
                            Text(gallery.name)
                                .font(Font.custom("Arvo", size: 24))
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(20), height: 20)
                            
                            Text(gallery.operation_hours)
                                .font(Font.custom("Pretendard-Medium", size: 14))
                            
                            Text("OPEN NOW")
                                .font(Font.custom("Arvo-BoldItalic", size: 14))
                            
                            Spacer()
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Image(systemName: "location")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(20), height: 20)
                            
                            Text(gallery.address)
                                .font(Font.custom("Pretendard-Medium", size: 14))
                            
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(-259))
                    .offset(y: getCustomizedScreenHeight(-259))
                    
                    if !galleryBannerList.isEmpty {
                        List {
                            PageView(pages: galleryBannerList.map { GalleryBannerItem(galleryBanner: $0) }, onDemandPage: $galleryBannerPageNumber, direction: $galleryBannerPageDirection, enableSwipe: true)
                                .aspectRatio(343 / 264, contentMode: .fit)
                                .listRowInsets(EdgeInsets())
                                .background(GalleryBannerBackground())
                        }
                        .listStyle(.inset)
                        .frame(width: getCustomizedScreenWidth(343), height: getCustomizedScreenHeight(264))
                        .padding(.bottom, getCustomizedScreenHeight(-150))
                        .offset(y: getCustomizedScreenHeight(-150))
                    } else {
                        Image("main")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(343), height: getCustomizedScreenHeight(264))
                            .padding(.bottom, getCustomizedScreenHeight(-150))
                            .offset(y: getCustomizedScreenHeight(-150))
                    }
                    
                    HStack {
                        Spacer()
                        
                        Image("previousArrow")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .opacity(galleryBannerPageNumber <= 0 ? 0.5 : 1)
                            .padding(.trailing, 8)
                            .onTapGesture {
                                if galleryBannerPageNumber > 0 {
                                    galleryBannerPageNumber -= 1
                                    galleryBannerPageDirection = UIPageViewController.NavigationDirection.reverse
                                }
                            }
                        
                        Image("nextArrow")
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .opacity(galleryBannerPageNumber >= galleryBannerList.count - 1 ? 0.5 : 1)
                            .onTapGesture {
                                if galleryBannerPageNumber < galleryBannerList.count - 1 {
                                    galleryBannerPageNumber += 1
                                    galleryBannerPageDirection = UIPageViewController.NavigationDirection.forward
                                }
                            }
                    }
                    .padding(.top, getCustomizedScreenHeight(8))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.GalleryView)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            firestoreUserRepository.user.favortieGalleryIds = getDistinctAddedIds(
                firestoreUserRepository.user.favortieGalleryIds, gallery.id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
            
            bothEndsConnected = false
            
            #if NOSERVER
                exhibitionList = modelData.exhibitionListData
                galleryBannerList = modelData.galleryBannerListData
            #else
                if let url = URL(string: "\(exhibitionListAPI_forId)\(gallery.id)") {
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
                
                if let url = URL(string: "\(galleryBannerListAPI_forId)\(gallery.id)") {
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        if let data = data {
                            do {
                                galleryBannerList = try JSONDecoder().decode([GalleryBanner].self, from: data)
                            } catch let error {
                                print("error = \(error)")
                            }
                        } else {
                            galleryBannerList = modelData.galleryBannerListData
                        }
                    }.resume()
                }
            #endif
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(gallery: Gallery())
            .environmentObject(ModelData())
    }
}

#else
struct GalleryView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var gallery: Gallery
    @State var exhibitionList = [Exhibition]()
    @State var galleryBannerList = [GalleryBanner]()
    @State var galleryBannerPageNumber = 0
    @State var galleryBannerPageDirection = UIPageViewController.NavigationDirection.forward
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack {
                    CustomBackground(offsetY: 0, backgroundColor: Color.customBlue)
                        .frame(height: getCustomizedScreenHeight(278))
                        .padding(.top, getCustomizedScreenHeight(110))
                    
                    VStack {
                        HStack {
                            Text(gallery.venue_nm)
                                .font(Font.custom("Arvo", size: 24))
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(20), height: 20)
                            
                            Text(gallery.venue_open_time)
                                .font(Font.custom("Pretendard-Medium", size: 14))
                            
                            Text("OPEN NOW")
                                .font(Font.custom("Arvo-BoldItalic", size: 14))
                            
                            Spacer()
                        }
                        .padding(.bottom, 1)
                        
                        HStack {
                            Image(systemName: "location")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(20), height: 20)
                            
                            Text(gallery.venue_addr)
                                .font(Font.custom("Pretendard-Medium", size: 14))
                            
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(-259))
                    .offset(y: getCustomizedScreenHeight(-259))
                    
                    if !galleryBannerList.isEmpty {
                        List {
                            PageView(pages: galleryBannerList.map { GalleryBannerItem(galleryBanner: $0) }, onDemandPage: $galleryBannerPageNumber, direction: $galleryBannerPageDirection, enableSwipe: true)
                                .aspectRatio(343 / 264, contentMode: .fit)
                                .listRowInsets(EdgeInsets())
                                .background(GalleryBannerBackground())
                        }
                        .listStyle(.inset)
                        .frame(width: getCustomizedScreenWidth(343), height: getCustomizedScreenHeight(264))
                        .padding(.bottom, getCustomizedScreenHeight(-150))
                        .offset(y: getCustomizedScreenHeight(-150))
                        .zIndex(8)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            if galleryBannerPageNumber > 0 {
                                galleryBannerPageNumber -= 1
                                galleryBannerPageDirection = UIPageViewController.NavigationDirection.reverse
                            }
                        }, label: {
                            Image("previousArrow")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .opacity(galleryBannerPageNumber <= 0 ? 0.5 : 1)
                                .padding(.trailing, 8)
                        })
                        
                        Button(action: {
                            if galleryBannerPageNumber < galleryBannerList.count - 1 {
                                galleryBannerPageNumber += 1
                                galleryBannerPageDirection = UIPageViewController.NavigationDirection.forward
                            }
                        }, label: {
                            Image("nextArrow")
                                .renderingMode(.template)
                                .foregroundColor(.black)
                                .opacity(galleryBannerPageNumber >= galleryBannerList.count - 1 ? 0.5 : 1)
                        })
                    }
                    .padding(.top, getCustomizedScreenHeight(8))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .zIndex(9)
                    
                    ExhibitionList(exhibitionList: exhibitionList, viewName: ViewName.GalleryView)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .task {
            var _: [UserDocentNote] = await httpGetPost(urlString: insertAppUserLogAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=VENUE" + "&targetId=" + String(gallery.venue_id))
            
            exhibitionList.removeAll()
            galleryBannerList.removeAll()
            
            for exhibition in modelData.artExhibitionListData {
                if exhibition.mapp_venue_id == gallery.venue_id {
                    exhibitionList.append(exhibition)
                }
            }
            
            var galleryBanner = GalleryBanner()
            for path in gallery.paths.components(separatedBy: ",") {
                galleryBanner.image_url = adminAddress + path
                galleryBannerList.append(galleryBanner)
            }
            
            firestoreUserRepository.user.favortieGalleryIds = getDistinctAddedIds(
                firestoreUserRepository.user.favortieGalleryIds, gallery.venue_id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
            
            bothEndsConnected = false
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(gallery: Gallery())
            .environmentObject(ModelData())
    }
}

#endif
