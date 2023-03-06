//
//  QRCodeScanView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/16.
//

import SwiftUI
import CodeScanner

#if LOCAL_API
struct QRCodeScanView: View {
    @EnvironmentObject var modelData: ModelData
    @State var deeplinkQuery: DeeplinkQuery?
    @State var disableParentScroll = false
    @State var gallery = Gallery()
    @State var exhibition = Exhibition()
    @State var work = Work()
    
    
    var body: some View {
        ZStack {
            MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                .zIndex(2)
            CodeScannerView(codeTypes: [.qr], completion: handleScan)
                .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(812))
                .edgesIgnoringSafeArea(.all)
            if deeplinkQuery != nil {
                NavigationLink {
                    switch deeplinkQuery {
                    case .main:
                        MainView(galleryList: modelData.galleryListData, exhibitionList: modelData.exhibitionListData, workList: modelData.workListData, docentTourList: modelData.docentTourListData)
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    case .gallery:
                        GalleryView(gallery: gallery)
                    case .exhibition:
                        ExhibitionView(exhibition: exhibition)
                    case .work:
                        WorkView(work: work, workList: modelData.workListData)
                    case .docentNote:
                        DocentNoteView(userDocentNoteList: modelData.userDocentListData) {}
                    case .none:
                        MainView(galleryList: modelData.galleryListData, exhibitionList: modelData.exhibitionListData, workList: modelData.workListData, docentTourList: modelData.docentTourListData)
                    }
                } label: {
                    switch deeplinkQuery {
                    case .main:
                        CustomCapsule(text: "메인 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .gallery:
                        CustomCapsule(text: "갤러리 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .exhibition:
                        CustomCapsule(text: "전시 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .work:
                        CustomCapsule(text: "작품 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .docentNote:
                        CustomCapsule(text: "도슨트노트 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .none:
                        CustomCapsule(text: "적절하지 않은 QR 코드입니다", foregroundColor: .black, backgroundColor: .yellow)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            if result.string.range(of: "gallery") != nil {
                deeplinkQuery = DeeplinkQuery.gallery
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    gallery = getGalleryById(id: Int(idValue)!, galleryList: modelData.galleryListData)
                }
                
            } else if result.string.range(of: "exhibition") != nil {
                deeplinkQuery = DeeplinkQuery.exhibition
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    exhibition = getExhibitionById(id: Int(idValue)!, exhibitionList: modelData.exhibitionListData)
                }
                
            } else if result.string.range(of: "work") != nil {
                deeplinkQuery = DeeplinkQuery.work
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    work = getWorkById(id: Int(idValue)!, workList: modelData.workListData)
                }
                
            } else {
                deeplinkQuery = DeeplinkQuery.main
            }
            print("result = \(result.string)")
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView()
    }
}

#else
struct QRCodeScanView: View {
    @EnvironmentObject var modelData: ModelData
    @State var deeplinkQuery: DeeplinkQuery?
    @State var disableParentScroll = false
    @State var gallery = Gallery()
    @State var exhibition = Exhibition()
    @State var work = Work()
    
    
    var body: some View {
        ZStack {
            MainHeader(showMainLogo: true, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                .zIndex(2)
            CodeScannerView(codeTypes: [.qr], completion: handleScan)
                .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(812))
                .edgesIgnoringSafeArea(.all)
            if deeplinkQuery != nil {
                NavigationLink {
                    switch deeplinkQuery {
                    case .main:
                        MainView(galleryList: modelData.artGalleryListData, exhibitionList: modelData.artExhibitionListData, workList: modelData.artWorkListData, docentTourList: modelData.artDocentTourListData)
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    case .gallery:
                        GalleryView(gallery: gallery)
                    case .exhibition:
                        ExhibitionView(exhibition: exhibition)
                    case .work:
                        WorkView(work: work, workList: [Work]())
                    case .docentNote:
                        DocentNoteView(userDocentNoteList: modelData.userDocentListData) {}
                    case .none:
                        MainView(galleryList: modelData.artGalleryListData, exhibitionList: modelData.artExhibitionListData, workList: modelData.artWorkListData, docentTourList: modelData.artDocentTourListData)
                    }
                } label: {
                    switch deeplinkQuery {
                    case .main:
                        CustomCapsule(text: "메인 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .gallery:
                        CustomCapsule(text: "갤러리 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .exhibition:
                        CustomCapsule(text: "전시 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .work:
                        CustomCapsule(text: "작품 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .docentNote:
                        CustomCapsule(text: "도슨트노트 바로 가기", foregroundColor: .black, backgroundColor: .yellow)
                    case .none:
                        CustomCapsule(text: "적절하지 않은 QR 코드입니다", foregroundColor: .black, backgroundColor: .yellow)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result {
        case .success(let result):
            if result.string.range(of: "venue") != nil {
                deeplinkQuery = DeeplinkQuery.gallery
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    gallery = getGalleryById(id: Int(idValue)!, galleryList: modelData.artGalleryListData)
                }
                
            } else if result.string.range(of: "exhibition") != nil {
                deeplinkQuery = DeeplinkQuery.exhibition
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    print("modelData.artExhibitionListData = \(modelData.artExhibitionListData)")
                    exhibition = getExhibitionById(id: Int(idValue)!, exhibitionList: modelData.artExhibitionListData)
                }
                
            } else if result.string.range(of: "artwork") != nil {
                deeplinkQuery = DeeplinkQuery.work
                
                if let idValue = result.string.components(separatedBy: "=").last {
                    print("modelData.artWorkListData = \(modelData.artWorkListData)")
                    work = getWorkById(id: Int(idValue)!, workList: modelData.artWorkListData)
                }
                
            } else {
                deeplinkQuery = DeeplinkQuery.main
            }
            print("result = \(result.string)")
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

struct QRCodeScanView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanView()
    }
}

#endif
