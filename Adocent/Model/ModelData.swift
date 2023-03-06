//
//  ModelData.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import Foundation

#if LOCAL_API
final class ModelData: ObservableObject {
    @Published var exhibitionListData: [Exhibition] = load("exhibitionListData.json")
    @Published var workListData: [Work] = load("workListData.json")
    @Published var galleryListData: [Gallery] = load("galleryListData.json")
    @Published var galleryBannerListData: [GalleryBanner] = load("galleryBannerListData.json")
    @Published var docentTourListData: [DocentTour] = load("docentTourListData.json")
    @Published var userDocentListData: [UserDocentNote] = load("userDocentListData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

#else
final class ModelData: ObservableObject {
    @Published var artExhibitionListData = [Exhibition]()
//    @Published var artWorkListData = [Work]()
    @Published var artWorkListData: [Work] = load("artWorkListData.json")
    @Published var artGalleryListData = [Gallery]()
    @Published var artGalleryBannerListData = [GalleryBanner]()
    @Published var artDocentTourListData = [DocentTour]()
    @Published var userDocentListData = [UserDocentNote]()
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

#endif
