//
//  WorkView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI
import AVKit
import YouTubePlayerKit

#if LOCAL_API
struct WorkView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    var work: Work
    var workList: [Work]
    @State var seeMore = false
    @State var disableParentScroll = false
    @State var workIndex = 0
    @State var videoUrl = ""
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: false, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    if videoUrl.range(of: "http") != nil {
                        VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                            .padding(.top, getCustomizedScreenHeight(120))
                            .padding(.bottom, getCustomizedScreenHeight(38))
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    } else {
                        YoutubeVideoView(youtubeVideoID: videoUrl)
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                            .padding(.top, getCustomizedScreenHeight(120))
                            .padding(.bottom, getCustomizedScreenHeight(38))
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    }
                    
                    HStack {
                        Text(work.name)
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image("sortIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(-2))
                    .offset(y: getCustomizedScreenHeight(-2))
                    
                    Text("\(work.artist_name), 2022")
                        .font(Font.custom("Pretendard", size: 18))
                        .foregroundColor(.white)
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(16))
                    
                    Text(work.commentary)
                        .lineLimit(seeMore ? nil : 3)
                        .font(Font.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(.white)
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(-6))
                        .offset(y: getCustomizedScreenHeight(-6))
                    
                    if !seeMore {
                        VStack {
                            Text("더보기")
                                .font(Font.custom("Pretendard-Bold", size: 14))
                                .foregroundColor(.customBlue)
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .onTapGesture {
                                    seeMore = true
                                }
                            
                            Rectangle()
                                .fill(Color.customBlue)
                                .frame(width: getCustomizedScreenWidth(40), height: getCustomizedScreenHeight(1.5))
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .offset(y: getCustomizedScreenHeight(-12))
                        }
                    }
                    
                    HStack {
                        ForEach(work.tags.components(separatedBy: " "), id: \.self) { tag in
                            NavigationLink {
                                ScrollView {
                                    SearchView(modelData: _modelData, searchText: tag, tags: [String](), isOpen: true, searchClose: {})
                                }
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                            } label: {
                                TagBox(tag: tag, foregroundColor: .white)
                            }
                        }
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenWidth(22))
                    
                    PrevNextButtons(workList: workList, workIndex: $workIndex, viewName: ViewName.WorkView)
                    
                    WorkList(workList: workList, foregroundColor: .white)
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(56))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            firestoreUserRepository.user.workIds = getDistinctAddedIds(
                firestoreUserRepository.user.workIds, work.id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
            
            if let index = workList.firstIndex(where: { $0.id == work.id }) {
                workIndex = index
            }
            
            if work.video_url.range(of: "youtu") != nil {
                if let url = work.video_url.components(separatedBy: "=").last {
                    videoUrl = url
                }
            }
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(work: Work(), workList: [Work]())
            .environmentObject(ModelData())
    }
}

#else
struct WorkView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    @EnvironmentObject var modelData: ModelData
    @State var exhibition = Exhibition()
    @State var work: Work
    @State var workList: [Work]
    @State var seeMore = false
    @State var disableParentScroll = false
    @State var workIndex = 0
    @State var videoUrl = ""
    @State var tagArray = [String]()
    @State var youTubePlayer = YouTubePlayer()
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: false, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    if videoUrl.range(of: "http") != nil {
                        VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                            .padding(.top, getCustomizedScreenHeight(120))
                            .padding(.bottom, getCustomizedScreenHeight(38))
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    } else {
                        YouTubePlayerView(self.youTubePlayer)
                            .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                            .padding(.top, getCustomizedScreenHeight(120))
                            .padding(.bottom, getCustomizedScreenHeight(38))
                            .navigationBarBackButtonHidden(true)
                            .navigationBarHidden(true)
                    }
                    
                    HStack {
                        Text(work.artwork_title)
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(-2))
                    .offset(y: getCustomizedScreenHeight(-2))
                    
                    Text("\(work.artwork_artist_nm), \(work.artwork_date)\n\(work.artwork_material), \(work.artwork_size)")
                        .font(Font.custom("Pretendard", size: 16))
                        .foregroundColor(.white)
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(16))
                    
                    ArtworkText(work: work, seeMore: seeMore)
                    
                    if !seeMore {
                        VStack {
                            Text("더보기")
                                .font(Font.custom("Pretendard-Bold", size: 14))
                                .foregroundColor(.customBlue)
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .onTapGesture {
                                    seeMore = true
                                }
                            
                            Rectangle()
                                .fill(Color.customBlue)
                                .frame(width: seeMore ? getCustomizedScreenWidth(25) : getCustomizedScreenWidth(40), height: getCustomizedScreenHeight(1.5))
                                .frame(width: getCustomizedScreenWidth(40), height: getCustomizedScreenHeight(1.5))
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .offset(y: getCustomizedScreenHeight(-12))
                        }
                    } else {
                        VStack {
                            Text("접기")
                                .font(Font.custom("Pretendard-Bold", size: 14))
                                .foregroundColor(.customBlue)
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .onTapGesture {
                                    seeMore = false
                                }
                            
                            Rectangle()
                                .fill(Color.customBlue)
                                .frame(width: seeMore ? getCustomizedScreenWidth(25) : getCustomizedScreenWidth(40), height: getCustomizedScreenHeight(1.5))
                                .padding(.leading, getCustomizedScreenWidth(16))
                                .offset(y: getCustomizedScreenHeight(-12))
                        }
                    }
                    
                    HStack {
                        ForEach(tagArray, id: \.self) { tag in
                            NavigationLink {
                                ScrollView(disableParentScroll ? [] : .vertical) {
                                    ZStack(alignment: .top) {
                                        MainHeader(showMainLogo: true, foregroundColor: .black, disableParentScroll: $disableParentScroll)
                                            .zIndex(1)
                                        SearchView(modelData: _modelData, searchText: tag, tags: [String](), isOpen: true, searchClose: {})
                                    }
                                }
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                                .edgesIgnoringSafeArea(.all)
                            } label: {
                                TagBox(tag: tag, foregroundColor: .white)
                            }
                        }
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenWidth(22))
                    
                    HStack {
                        Button(action: {
                            if workIndex == 0 {
                                workIndex = workList.count - 1
                            } else {
                                workIndex -= 1
                            }
                            
                            work = workList[workIndex]
                            videoUrl = work.artwork_view_url
                            
                            if videoUrl.range(of: "watch") != nil {
                                if let url = work.artwork_view_url.components(separatedBy: "=").last {
                                    videoUrl = url
                                    let player = YouTubePlayer(
                                        source: .video(id: videoUrl),
                                        configuration: .init(
                                            
                                        )
                                    )
                                    youTubePlayer = player
                                }
                            }
                        }, label: {
                            HStack {
                                Image("previousArrow")
                                    .resizable()
                                    .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(14))
                                    .foregroundColor(.customWhite)
                                
                                Text("이전")
                                    .font(Font.custom("Pretendard-Medium", size: 16))
                                    .foregroundColor(.white)
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            if workIndex == workList.count - 1 {
                                workIndex = 0
                            } else {
                                workIndex += 1
                            }
                            
                            work = workList[workIndex]
                            videoUrl = work.artwork_view_url
                            
                            if videoUrl.range(of: "watch") != nil {
                                if let url = work.artwork_view_url.components(separatedBy: "=").last {
                                    videoUrl = url
                                    let player = YouTubePlayer(
                                        source: .video(id: videoUrl),
                                        configuration: .init(
                                            
                                        )
                                    )
                                    youTubePlayer = player
                                }
                            }
                        }, label: {
                            HStack {
                                Image("nextArrow")
                                    .resizable()
                                    .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(14))
                                    .foregroundColor(.customWhite)
                                
                                Text("다음")
                                    .font(Font.custom("Pretendard-Medium", size: 16))
                                    .foregroundColor(.white)
                            }
                        })
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    
                    VStack {
                        ForEach(workList, id: \.self.artwork_id) { work in
                            Button(action: {
                                self.work = work
                                workList.remove(at: workList.firstIndex(of: self.work) ?? 0)
                                workList.append(self.work)
                                videoUrl = self.work.artwork_view_url
                                
                                if videoUrl.range(of: "watch") != nil {
                                    if let url = work.artwork_view_url.components(separatedBy: "=").last {
                                        videoUrl = url
                                        let player = YouTubePlayer(
                                            source: .video(id: videoUrl),
                                            configuration: .init(
                                                
                                            )
                                        )
                                        youTubePlayer = player
                                    }
                                }
                            }, label: {
                                WorkListItem(work: work, foregroundColor: .white)
                            })
                        }
                    }
                    
                    NavigationLink {
                        ExhibitionView(exhibition: exhibition)
                    } label: {
                        WhiteButton(text: "전시회 전체 보기", width: 343)
                    }
                    
                    // 푸터
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(56))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(48))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .task {
            var _: [UserDocentNote] = await httpGetPost(urlString: insertAppUserLogAPI, bodyString: apiBody, parameterString: "?loginId=" + (UserDefaults.standard.string(forKey: "AppleLoginID") ?? "") + "&targetType=ARTWORK" + "&targetId=" + String(work.artwork_id))
            
            if workList.isEmpty {
                for work in modelData.artWorkListData {
                    if self.work.main_exhibition_id == work.main_exhibition_id {
                        workList.append(work)
                    }
                }
            }
            
            for exhibition in modelData.artExhibitionListData {
                if self.work.main_exhibition_id == exhibition.exhibition_id {
                    self.exhibition = exhibition
                }
            }
            
            var tags = [String]()
            tagArray = work.artwork_tag.components(separatedBy: " ")
            if tagArray.count > 2 {
                for index in 0...2 {
                    tags.append(tagArray[index])
                }
            }
            tagArray = tags
            
            firestoreUserRepository.user.workIds = getDistinctAddedIds(
                firestoreUserRepository.user.workIds, work.artwork_id
            )
            firestoreUserRepository.update(firestoreUserRepository.user)
            
            if let index = workList.firstIndex(where: { $0.artwork_id == work.artwork_id }) {
                workIndex = index
            }
            
            if work.artwork_view_url.range(of: "watch") != nil {
                if let url = work.artwork_view_url.components(separatedBy: "=").last {
                    videoUrl = url
                    let player = YouTubePlayer(
                        source: .video(id: videoUrl),
                        configuration: .init(
                            
                        )
                    )
                    youTubePlayer = player
                }
            }
        }
    }
}

struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        WorkView(work: Work(), workList: [Work]())
            .environmentObject(ModelData())
    }
}

#endif
