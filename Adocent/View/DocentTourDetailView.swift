//
//  DocentTourDetailView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/08.
//

import SwiftUI
import AVKit

#if LOCAL_API
struct DocentTourDetailView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    var work: Work
    var workList: [Work]
    @State var seeMore = false
    @State var disableParentScroll = false
    @State var likeCount = 0
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
                        
                        VStack {
                            Button(action: {
                                likeCount += 1
                                firestoreUserRepository.user.favoriteWorkIds = getDistinctAddedIds(
                                    firestoreUserRepository.user.favoriteWorkIds, work.id
                                )
                                firestoreUserRepository.update(firestoreUserRepository.user)
                            }, label: {
                                Image("heartIcon")
                                    .resizable()
                                    .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                                    .foregroundColor(.white)
                            })
                            
                            Text("\(likeCount)")
                                .font(Font.custom("Pretendard-Medium", size: 12))
                                .foregroundColor(.white)
                                .offset(y: getCustomizedScreenHeight(-3))
                                .padding(.bottom, getCustomizedScreenHeight(-3))
                        }
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
                    
                    Text(!seeMore ?
                         "\(work.commentary.prefix(upTo: work.commentary.index(work.commentary.startIndex, offsetBy: work.commentary.count / 2))) ..."
                         : work.commentary)
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
                                .padding(.bottom, getCustomizedScreenHeight(-12))
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: getCustomizedScreenWidth(16)) {
                            ForEach(work.name.components(separatedBy: " "), id: \.self) { tag in
                                Button(action: {
                                    
                                }, label: {
                                    CustomCapsule(text: tag, foregroundColor: .black, backgroundColor: .customGray)
                                        .padding(.trailing, -8)
                                })
                            }
                        }
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.top, !seeMore ? 0 : getCustomizedScreenWidth(14))
                    .padding(.bottom, getCustomizedScreenWidth(22))
                    PrevNextButtons(workList: workList, workIndex: $workIndex, viewName: ViewName.DocentTourDetailView)
                    
                    HStack {
                        Text("투어 내 해설 작품")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.white)
                        
                        Text("\(workList.count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-12.5))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    DocentTourWorkList(workList: workList, foregroundColor: .white)
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(66))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
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

struct DocentTourDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourDetailView(work: Work(), workList: [Work]())
    }
}

#else
struct DocentTourDetailView: View {
    @EnvironmentObject var firestoreUserRepository: FirestoreUserRepository
    var work: Work
    var workList: [Work]
    @State var seeMore = false
    @State var disableParentScroll = false
    @State var likeCount = 0
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
                    
                    // 제목
                    HStack {
                        Text(work.artwork_title)
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack {
                            Button(action: {
                                likeCount += 1
                                firestoreUserRepository.user.favoriteWorkIds = getDistinctAddedIds(
                                    firestoreUserRepository.user.favoriteWorkIds, work.artwork_id
                                )
                                firestoreUserRepository.update(firestoreUserRepository.user)
                            }, label: {
                                Image("heartIcon")
                                    .resizable()
                                    .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                                    .foregroundColor(.white)
                            })
                            
                            Text("\(likeCount)")
                                .font(Font.custom("Pretendard-Medium", size: 12))
                                .foregroundColor(.white)
                                .offset(y: getCustomizedScreenHeight(-3))
                                .padding(.bottom, getCustomizedScreenHeight(-3))
                        }
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(-2))
                    .offset(y: getCustomizedScreenHeight(-2))
                    
                    Text("\(work.artwork_artist_nm), \(work.artwork_date)")
                        .font(Font.custom("Pretendard", size: 18))
                        .foregroundColor(.white)
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(16))
                    
                    Text(!seeMore ?
                         "\(work.artwork_text.prefix(upTo: work.artwork_text.index(work.artwork_text.startIndex, offsetBy: work.artwork_text.count / 2))) ..."
                         : work.artwork_text)
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
                                .padding(.bottom, getCustomizedScreenHeight(-12))
                        }
                    }
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .top, spacing: getCustomizedScreenWidth(16)) {
                            ForEach(work.artwork_title.components(separatedBy: " "), id: \.self) { tag in
                                Button(action: {
                                    
                                }, label: {
                                    CustomCapsule(text: tag, foregroundColor: .black, backgroundColor: .customGray)
                                        .padding(.trailing, -8)
                                })
                            }
                        }
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.top, !seeMore ? 0 : getCustomizedScreenWidth(14))
                    .padding(.bottom, getCustomizedScreenWidth(22))
                    PrevNextButtons(workList: workList, workIndex: $workIndex, viewName: ViewName.DocentTourDetailView)
                    
                    HStack {
                        Text("투어 내 해설 작품")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.white)
                        
                        Text("\(workList.count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-12.5))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    DocentTourWorkList(workList: workList, foregroundColor: .white)
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(66))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            if let index = workList.firstIndex(where: { $0.artwork_id == work.artwork_id }) {
                workIndex = index
            }
            
            if work.artwork_view_url.range(of: "watch") != nil {
                if let url = work.artwork_view_url.components(separatedBy: "=").last {
                    videoUrl = url
                }
            }
        }
    }
}

struct DocentTourDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourDetailView(work: Work(), workList: [Work]())
    }
}

#endif
