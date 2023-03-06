//
//  Structs.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/09.
//

import SwiftUI
import WebKit
import AVKit

struct YoutubeVideoView: UIViewRepresentable {
    var youtubeVideoID: String
    
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let youtubePath = "https://www.youtube.com/embed/\(youtubeVideoID)"
        guard let youtubeUrl = URL(string: youtubePath) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: youtubeUrl))
    }
}

struct CustomPlayer: UIViewControllerRepresentable {
    let urlString: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomPlayer>) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: URL(string: urlString)!)
        controller.player = player
        controller.showsPlaybackControls = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play()
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<CustomPlayer>) { }
}
