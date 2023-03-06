//
//  URLImage.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/18.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(withURL: String())
    }
}
