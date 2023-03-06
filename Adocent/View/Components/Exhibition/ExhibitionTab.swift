//
//  ExhibitionTab.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI
import AVKit
import YouTubePlayerKit

#if LOCAL_API
struct ExhibitionTab: View {
    var exhibition: Exhibition
    var workList: [Work]
    @State var seeMore = false
    @State var videoUrl = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if videoUrl.range(of: "http") != nil {
                VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                    .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } else {
                YoutubeVideoView(youtubeVideoID: videoUrl)
                    .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            
            Text(exhibition.name)
                .font(Font.custom("Arvo", size: 20))
                .foregroundColor(.white)
                .padding(.top, getCustomizedScreenWidth(16))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(6))
            
            Text(!seeMore ?
                 "\(exhibition.commentary.prefix(upTo: exhibition.commentary.index(exhibition.commentary.startIndex, offsetBy: exhibition.commentary.count / 2))) ..."
                 : exhibition.commentary)
                .font(Font.custom("Pretendard-Medium", size: 14))
                .foregroundColor(.white)
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
            
            // 더보기
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
            
            NavigationLink {
                if !workList.isEmpty {
                    WorkView(work: workList.first!, workList: workList)
                } else {
                    EmptyView()
                }
            } label: {
                WhiteButton(text: "작품 해설 듣기", width: 343)
            }
        }
        .onAppear() {
            if exhibition.video_url.range(of: "youtu") != nil {
                if let url = exhibition.video_url.components(separatedBy: "=").last {
                    videoUrl = url
                }
            }
        }
    }
}

struct ExhibitionTab_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionTab(exhibition: Exhibition(), workList: [Work]())
    }
}
#else
struct ExhibitionTab: View {
    var exhibition: Exhibition
    var workList: [Work]
    @State var seeMore = false
    @State var videoUrl = ""
    @State var youTubePlayer = YouTubePlayer()
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            if videoUrl.range(of: "http") != nil {
                VideoPlayer(player: AVPlayer(url: URL(string: videoUrl)!))
                    .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            } else {
                YouTubePlayerView(self.youTubePlayer)
                    .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(211))
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .navigationBarBackButtonHidden(true)
                    .navigationBarHidden(true)
            }
            
            Text(exhibition.exhibition_nm)
                .font(Font.custom("Arvo", size: 20))
                .foregroundColor(.white)
                .padding(.top, getCustomizedScreenWidth(16))
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(6))
            
            Text(exhibition.exhibition_text)
                .font(Font.custom("Pretendard-Medium", size: 14))
                .foregroundColor(.white)
                .padding(.leading, getCustomizedScreenWidth(16))
                .padding(.trailing, getCustomizedScreenWidth(16))
                .padding(.bottom, getCustomizedScreenHeight(22))
            
            Button(action: {
                tabIndex = 0
            }, label: {
                WhiteButton(text: "작품 해설 듣기", width: 343)
            })
        }
        .onAppear() {
            if exhibition.exhibition_intro_url.range(of: "watch") != nil {
                if let url = exhibition.exhibition_intro_url.components(separatedBy: "=").last {
                    videoUrl = url
                    let player = YouTubePlayer(
                        source: .video(id: videoUrl),
                        configuration: .init(
//                            autoPlay: true
                        )
                    )
                    youTubePlayer = player
                }
            }
        }
    }
}

//struct ExhibitionTab_Previews: PreviewProvider {
//    static var previews: some View {
//        ExhibitionTab(exhibition: Exhibition(), workList: [Work](), tabIndex: 0)
//    }
//}
#endif
