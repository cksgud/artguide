//
//  ExhibitionView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI

#if LOCAL_API
struct ExhibitionView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    var exhibition: Exhibition
    @State var tabIndex = 0
    @State var docentTourList = [DocentTour]()
    @State var workList = [Work]()
    @State var disableParentScroll = false
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack {
                    ZStack(alignment: .top) {
                        URLImage(withURL: exhibition.image_url)
                            .frame(height: getCustomizedScreenHeight(760))
                        
                        HStack {
                            Image("left_bracket_white")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                                .padding(.leading, getCustomizedScreenWidth(16))
                            
                            Spacer()
                            
                            Image("right_bracket_white")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(6), height: getCustomizedScreenHeight(240))
                                .padding(.trailing, getCustomizedScreenWidth(16))
                        }
                        .padding(.top, getCustomizedScreenHeight(298))
                        
                        HStack {
                            Text(exhibition.name)
                                .font(Font.custom("Arvo", size: 32))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, getCustomizedScreenHeight(570))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        
                        HStack {
                            Text("\(exhibition.start_date) - \(exhibition.end_date)")
                                .font(Font.custom("Pretendard-Medium", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, getCustomizedScreenHeight(666))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        
                        HStack {
                            Text("Gallery BK")
                                .font(Font.custom("Pretendard-Medium", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, getCustomizedScreenHeight(693))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        
                    }
                    
                    TopTabBar(tabAlignment: .center, textSize: 20, firstTabText: "작품 해설",secondTabText: "전시 소개" ,tabIndex: $tabIndex, workCount: workList.count)
                        .padding(.top, getCustomizedScreenHeight(28))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .opacity(tabIndex == 0 ? 1 : 0.3)
                            .frame(width: getCustomizedScreenWidth(171.5), height: getCustomizedScreenHeight(tabIndex == 0 ? 2 : 1))
                            .padding(.leading, getCustomizedScreenWidth(16))
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(Color.white)
                            .opacity(tabIndex == 1 ? 1 : 0.3)
                            .frame(width: getCustomizedScreenWidth(171.5), height: getCustomizedScreenHeight(tabIndex == 1 ? 2 : 1))
                            .offset(x: getCustomizedScreenWidth(-10))
                            .padding(.trailing, getCustomizedScreenWidth(16))
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    if tabIndex == 0 {
                        WorkTab(docentTourList: docentTourList, workList: workList)
                    } else {
                        ExhibitionTab(exhibition: exhibition, workList: workList)
                    }
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            firestoreUserRepository.user.exhibitionIds = getDistinctAddedIds(
                firestoreUserRepository.user.exhibitionIds, exhibition.id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
            
            #if NOSERVER
                docentTourList = modelData.docentTourListData
                workList = modelData.workListData
            #else
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
                
                if let url = URL(string: "\(workListAPI_forExhibitionId)\(exhibition.id)") {
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
            #endif
        }
    }
}

struct ExhibitionView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionView(exhibition: Exhibition())
            .environmentObject(ModelData())
    }
}

#else
struct ExhibitionView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    var exhibition: Exhibition
    @State var tabIndex = 0
    @State var docentTourList = [DocentTour]()
    @State var workList = [Work]()
    @State var disableParentScroll = false
    @State var gallery = Gallery()
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack {
                    ZStack(alignment: .top) {
                        URLImage(withURL: adminAddress + exhibition.exhibition_img_path)
                            .frame(height: getCustomizedScreenHeight(760))
                        
                        HStack {
                            Image("left_bracket_white")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(240))
                                .padding(.leading, getCustomizedScreenWidth(16))
                            
                            Spacer()
                            
                            Image("right_bracket_white")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(240))
                                .padding(.trailing, getCustomizedScreenWidth(16))
                        }
                        .padding(.top, getCustomizedScreenHeight(298))
                        
                        HStack {
                            Text(exhibition.exhibition_nm)
                                .font(Font.custom("Arvo", size: 32))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, getCustomizedScreenHeight(570))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        
                        NavigationLink {
                            GalleryView(gallery: gallery)
                        } label: {
                            HStack {
                                Text(exhibition.venue_nm)
                                    .font(Font.custom("Pretendard-Medium", size: 16))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.top, getCustomizedScreenHeight(666))
                            .padding(.leading, getCustomizedScreenWidth(16))
                        }
                        
                        HStack {
                            Text("\(exhibition.exhibition_start_date) - \(exhibition.exhibition_end_date)")
                                .font(Font.custom("Pretendard-Medium", size: 16))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.top, getCustomizedScreenHeight(693))
                        .padding(.leading, getCustomizedScreenWidth(16))
                    }
                    
                    TopTabBar(tabAlignment: .center, textSize: 20, firstTabText: "AI 작품 해설", secondTabText: "전시 소개" , tabIndex: $tabIndex, workCount: workList.count)
                        .padding(.top, getCustomizedScreenHeight(28))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                    
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .opacity(tabIndex == 0 ? 1 : 0.3)
                            .frame(width: getCustomizedScreenWidth(171.5), height: getCustomizedScreenHeight(tabIndex == 0 ? 2 : 1))
                            .padding(.leading, getCustomizedScreenWidth(12))
                        
                        Spacer()
                        
                        Rectangle()
                            .fill(Color.white)
                            .opacity(tabIndex == 1 ? 1 : 0.3)
                            .frame(width: getCustomizedScreenWidth(171.5), height: getCustomizedScreenHeight(tabIndex == 1 ? 2 : 1))
                            .offset(x: getCustomizedScreenWidth(-10))
                            .padding(.trailing, getCustomizedScreenWidth(12))
                    }
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    if tabIndex == 0 {
                        WorkTab(docentTourList: docentTourList, workList: workList)
                    } else {
                        ExhibitionTab(exhibition: exhibition, workList: workList, tabIndex: $tabIndex)
                    }
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .task {
            var _: [UserDocentNote] = await httpGetPost(urlString: insertAppUserLogAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=EXHIBITION" + "&targetId=" + String(exhibition.exhibition_id))
            
            docentTourList = modelData.artDocentTourListData
            workList.removeAll()
            for work in modelData.artWorkListData {
                if work.main_exhibition_id == exhibition.exhibition_id {
                    workList.append(work)
                }
            }
            
            for gallery in modelData.artGalleryListData {
                if gallery.venue_id == exhibition.mapp_venue_id {
                    self.gallery = gallery
                }
            }
            
            firestoreUserRepository.user.exhibitionIds = getDistinctAddedIds(
                firestoreUserRepository.user.exhibitionIds, exhibition.exhibition_id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
        }
    }
}

struct ExhibitionView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionView(exhibition: Exhibition())
            .environmentObject(ModelData())
    }
}
#endif
