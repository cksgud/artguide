//
//  DocentNoteView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI

#if LOCAL_API
struct DocentNoteView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var tabIndex = 0
    @State var userDocentNoteList: [UserDocentNote]
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    @State var exhibitionList = [Exhibition]()
    @State var firstHalf = [Exhibition]()
    @State var secondHalf = [Exhibition]()
    @State var workListSeen = [Work]()
    @State var workListFavorite = [Work]()
    @State var galleryList = [Gallery]()
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(getRandomProfileImageName())
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenWidth(28))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .shadow(radius: getCustomizedScreenWidth(28))
                        
                        Text("\(String(describing: UserDefaults.standard.string(forKey: "UserNickname") ?? "고객"))님의 도슨트노트")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(6))
                        
                        Spacer()
                    }
                    
                    Text("내가 본 전시")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding(.top, getCustomizedScreenHeight(70))
                    if exhibitionList.isEmpty {
                        Text("아직 내가 본 전시가 없어요")
                            .font(Font.custom("Pretendard-Medium", size: 15))
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .padding(.top, getCustomizedScreenHeight(5))
                    } else {
                        HStack {
                            VStack {
                                ForEach(firstHalf) { exhibition in
                                    NavigationLink {
                                        ExhibitionView(exhibition: exhibition)
                                    } label: {
                                        ExhibitionHistoryListItem(exhibition: exhibition, galleryList: galleryList, foregroundColor: .white)
                                    }
                                }
                            }
                            
                            VStack {
                                ForEach(secondHalf) { exhibition in
                                    NavigationLink {
                                        ExhibitionView(exhibition: exhibition)
                                    } label: {
                                        ExhibitionHistoryListItem(exhibition: exhibition, galleryList: galleryList, foregroundColor: .white)
                                    }
                                }
                            }
                        }
                    }
                    
                    // 탭
                    TopTabBar(tabAlignment: TabAlignment.leading, textSize: 24, firstTabText: "내가 본 작품 해설", secondTabText: "즐겨찾기", tabIndex: $tabIndex, workCount: -1)
                        .padding(.top, getCustomizedScreenHeight(70))
                    if tabIndex == 0 {
                        if workListSeen.isEmpty {
                            Text("아직 내가 본 작품이 없어요")
                                .font(Font.custom("Pretendard-Medium", size: 15))
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.top, getCustomizedScreenHeight(5))
                        } else {
                            ForEach(workListSeen) { work in
                                NavigationLink {
                                    WorkView(work: work, workList: workListSeen)
                                } label: {
                                    WorkListItem(work: work, foregroundColor: .white)
                                        .padding(.leading, getCustomizedScreenWidth(-16))
                                        .padding(.trailing, getCustomizedScreenWidth(-16))
                                }
                            }
                        }
                    } else {
                        if workListFavorite.isEmpty {
                            HStack {
                                Spacer()
                                
                                Text("즐겨찾기 등록한 작품이 없어요")
                                    .font(Font.custom("Pretendard-Medium", size: 15))
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                    .padding(.top, getCustomizedScreenHeight(5))
                            }
                        } else {
                            ForEach(workListFavorite) { work in
                                NavigationLink {
                                    WorkView(work: work, workList: workListFavorite)
                                } label: {
                                    WorkListItem(work: work, foregroundColor: .white)
                                        .padding(.leading, getCustomizedScreenWidth(-16))
                                        .padding(.trailing, getCustomizedScreenWidth(-16))
                                }
                            }
                        }
                    }
                    
                    Text("즐겨찾는 전시관")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding(.top, getCustomizedScreenHeight(56))
                    if workListFavorite.isEmpty {
                        Text("즐겨찾기 등록한 전시관이 없어요")
                            .font(Font.custom("Pretendard-Medium", size: 15))
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .padding(.top, getCustomizedScreenHeight(5))
                    } else {
                        ForEach(galleryList) { gallery in
                            NavigationLink {
                                GalleryView(gallery: gallery)
                            } label: {
                                GalleryNameBox(galleryName: gallery.name, foregroundColor: .white)
                            }
                        }
                    }
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
                .padding(.top, getCustomizedScreenHeight(136))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            exhibitionList.removeAll()
            firstHalf.removeAll()
            secondHalf.removeAll()
            
            workListSeen.removeAll()
            workListFavorite.removeAll()
            galleryList.removeAll()
            
            let exhibitionIds = firestoreUserRepository.user.exhibitionIds.split(separator: " ")
            let workIds = firestoreUserRepository.user.workIds.split(separator: " ")
            let favoriteWorkIds = firestoreUserRepository.user.favoriteWorkIds.split(separator: " ")
            let galleryIds = firestoreUserRepository.user.favortieGalleryIds.split(separator: " ")
            
            for exhibition in modelData.exhibitionListData {
                for exhibitionId in exhibitionIds {
                    if Int(exhibitionId) == exhibition.id {
                        exhibitionList.append(exhibition)
                    }
                }
            }
            for count in 0..<exhibitionList.count / 2 {
                firstHalf.append(exhibitionList[count])
            }
            for count in exhibitionList.count / 2..<exhibitionList.count {
                secondHalf.append(exhibitionList[count])
            }
            
            for work in modelData.workListData {
                for workId in workIds {
                    if Int(workId) == work.id {
                        workListSeen.append(work)
                    }
                }
            }
            
            for work in modelData.workListData {
                for favoriteWorkId in favoriteWorkIds {
                    if Int(favoriteWorkId) == work.id {
                        workListFavorite.append(work)
                    }
                }
            }
            
            for gallery in modelData.galleryListData {
                for galleryId in galleryIds {
                    if Int(galleryId) == gallery.id {
                        galleryList.append(gallery)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct DocentNoteView_Previews: PreviewProvider {
    static var previews: some View {
        DocentNoteView(userDocentNoteList: [UserDocentNote](), menuClose: {
            
        })
        .environmentObject(ModelData())
    }
}

#else
struct DocentNoteView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var tabIndex = 0
    @State var userDocentNoteList: [UserDocentNote]
    let menuClose: () -> Void
    @State var disableParentScroll = false
    
    @State var exhibitionList = [Exhibition]()
    @State var firstHalf = [Exhibition]()
    @State var secondHalf = [Exhibition]()
    @State var workListSeen = [Work]()
    @State var workListFavorite = [Work]()
    @State var galleryList = [Gallery]()
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(getRandomProfileImageName())
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenWidth(28))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .shadow(radius: getCustomizedScreenWidth(28))
                        
                        Text("\(String(describing: UserDefaults.standard.string(forKey: "UserNickname") ?? "고객"))님의 도슨트 노트")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(6))
                        
                        Spacer()
                    }
                    
                    Text("내가 본 전시")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding(.top, getCustomizedScreenHeight(70))
                    if exhibitionList.isEmpty {
                        Text("아직 내가 본 전시가 없어요")
                            .font(Font.custom("Pretendard-Medium", size: 15))
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .padding(.top, getCustomizedScreenHeight(5))
                    } else {
                        HStack {
                            VStack {
                                ForEach(firstHalf, id:\.self.exhibition_id) { exhibition in
                                    NavigationLink {
                                        ExhibitionView(exhibition: exhibition)
                                    } label: {
                                        ExhibitionHistoryListItem(exhibition: exhibition, galleryList: galleryList, foregroundColor: .white)
                                    }
                                }
                            }
                            
                            VStack {
                                ForEach(secondHalf, id:\.self.exhibition_id) { exhibition in
                                    NavigationLink {
                                        ExhibitionView(exhibition: exhibition)
                                    } label: {
                                        ExhibitionHistoryListItem(exhibition: exhibition, galleryList: galleryList, foregroundColor: .white)
                                    }
                                }
                            }
                            .offset(y: firstHalf.count > secondHalf.count ? getCustomizedScreenHeight(-250) : 0)
                            .padding(.bottom, firstHalf.count > secondHalf.count ? getCustomizedScreenHeight(-250) : 0)
                        }
                    }
                    
                    TopTabBar(tabAlignment: TabAlignment.leading, textSize: 24, firstTabText: "내가 본 작품 해설", secondTabText: "즐겨찾기", tabIndex: $tabIndex, workCount: -1)
                        .padding(.top, getCustomizedScreenHeight(70))
                    if tabIndex == 0 {
                        if workListSeen.isEmpty {
                            Text("아직 내가 본 작품이 없어요")
                                .font(Font.custom("Pretendard-Medium", size: 15))
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .padding(.top, getCustomizedScreenHeight(5))
                        } else {
                            ForEach(workListSeen, id: \.self.artwork_id) { work in
                                NavigationLink {
                                    WorkView(work: work, workList: workListSeen)
                                } label: {
                                    WorkListItem(work: work, foregroundColor: .white)
                                        .padding(.leading, getCustomizedScreenWidth(-16))
                                        .padding(.trailing, getCustomizedScreenWidth(-16))
                                }
                            }
                        }
                    } else {
                        if workListFavorite.isEmpty {
                            HStack {
                                Spacer()
                                
                                Text("즐겨찾기 등록한 작품이 없어요")
                                    .font(Font.custom("Pretendard-Medium", size: 15))
                                    .foregroundColor(.white)
                                    .opacity(0.5)
                                    .padding(.top, getCustomizedScreenHeight(5))
                            }
                        } else {
                            ForEach(workListFavorite, id: \.self.artwork_id) { work in
                                NavigationLink {
                                    WorkView(work: work, workList: workListFavorite)
                                } label: {
                                    WorkListItem(work: work, foregroundColor: .white)
                                        .padding(.leading, getCustomizedScreenWidth(-16))
                                        .padding(.trailing, getCustomizedScreenWidth(-16))
                                }
                            }
                        }
                    }
                    
                    Text("내가 본 전시관")
                        .font(Font.custom("Pretendard-Bold", size: 24))
                        .foregroundColor(.white)
                        .padding(.top, getCustomizedScreenHeight(56))
                    ForEach(galleryList, id:\.self.venue_id) { gallery in
                        NavigationLink {
                            GalleryView(gallery: gallery)
                        } label: {
                            GalleryNameBox(galleryName: gallery.venue_nm, foregroundColor: .white)
                        }
                    }
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
                .padding(.top, getCustomizedScreenHeight(136))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .task {
            let exhibitionTargetIdList: [DocentNoteTargetId] = await httpGetPost(urlString: docentNoteTargetIdListAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=EXHIBITION")
            
            let artWorkTargetIdList: [DocentNoteTargetId] = await httpGetPost(urlString: docentNoteTargetIdListAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=ARTWORK")
            
            let venueTargetIdList: [DocentNoteTargetId] = await httpGetPost(urlString: docentNoteTargetIdListAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=VENUE")
            
            exhibitionList.removeAll()
            firstHalf.removeAll()
            secondHalf.removeAll()
            
            workListSeen.removeAll()
            workListFavorite.removeAll()
            galleryList.removeAll()
            
            for exhibition in modelData.artExhibitionListData {
                for targetInfo in exhibitionTargetIdList {
                    if targetInfo.target_id == exhibition.exhibition_id {
                        exhibitionList.append(exhibition)
                    }
                }
            }
            
            let doubleHalfCount = ceil(Double(exhibitionList.count) / 2)
            let firstHalfCount = Int(doubleHalfCount)
            
            for count in 0..<firstHalfCount {
                firstHalf.append(exhibitionList[count])
            }
            for count in firstHalfCount..<exhibitionList.count {
                secondHalf.append(exhibitionList[count])
            }
            
            for work in modelData.artWorkListData {
                for targetInfo in artWorkTargetIdList {
                    if targetInfo.target_id == work.artwork_id {
                        workListSeen.append(work)
                    }
                }
            }
            
            for gallery in modelData.artGalleryListData {
                for targetInfo in venueTargetIdList {
                    if targetInfo.target_id == gallery.venue_id {
                        galleryList.append(gallery)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct DocentNoteView_Previews: PreviewProvider {
    static var previews: some View {
        DocentNoteView(userDocentNoteList: [UserDocentNote](), menuClose: {
            
        })
        .environmentObject(ModelData())
    }
}

#endif
