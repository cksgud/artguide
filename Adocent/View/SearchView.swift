//
//  SearchView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import SwiftUI

#if LOCAL_API
struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @State var searchText = ""
    @State var tags = [String]()
    let isOpen: Bool
    let searchClose: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                UnderlinedTextField(textfieldInput: $searchText, textfieldPlaceholder: "Search", width: 343)
                    .foregroundColor(.black)
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .font(Font.custom("Pretendard-Medium", size: 32))
                
                if searchText == "" {
                    HStack {
                        ForEach(tags, id: \.self) { tag in
                            Button(action: {
                                searchText = tag
                            }, label: {
                                TagBox(tag: tag, foregroundColor: .black)
                            })
                        }
                    }
                    .padding(.bottom, getCustomizedScreenWidth(22))
                } else {
                    HStack {
                        Text("'\(searchText)' 검색결과 총")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                        Text("\(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.exhibitionListData).count + getSearchedWorkList(searchString: searchText, workList: modelData.workListData).count + getSearchedGalleryList(searchString: searchText, galleryList: modelData.galleryListData).count)")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.blue)
                        Text("건")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .offset(x: getCustomizedScreenWidth(-5))
                            .padding(.trailing, getCustomizedScreenWidth(-5))
                    }
                }
                
                if getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.exhibitionListData).count > 0 {
                    HStack {
                        Text("전시")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.exhibitionListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    HStack {
                        ForEach(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.exhibitionListData)) { exhibition in
                            NavigationLink {
                                ExhibitionView(exhibition: exhibition)
                            } label: {
                                ExhibitionHistoryListItem(exhibition: exhibition, galleryList: modelData.galleryListData, foregroundColor: .black)
                            }
                        }
                    }
                }
                
                if getSearchedWorkList(searchString: searchText, workList: modelData.workListData).count > 0 {
                    HStack {
                        Text("작품")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedWorkList(searchString: searchText, workList: modelData.workListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    WorkList(workList: getSearchedWorkList(searchString: searchText, workList: modelData.workListData), foregroundColor: .black)
                        .padding(.leading, getCustomizedScreenWidth(-16))
                        .padding(.trailing, getCustomizedScreenWidth(-16))
                }
                
                if getSearchedGalleryList(searchString: searchText, galleryList: modelData.galleryListData).count > 0 {
                    HStack {
                        Text("전시관")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedGalleryList(searchString: searchText, galleryList: modelData.galleryListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    HStack {
                        ForEach(getSearchedGalleryList(searchString: searchText, galleryList: modelData.galleryListData)) { gallery in
                            NavigationLink {
                                GalleryView(gallery: gallery)
                            } label: {
                                GalleryNameBox(galleryName: gallery.name, foregroundColor: .black)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .padding(.top, getCustomizedScreenHeight(108))
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        .padding(.bottom, getCustomizedScreenHeight(48))
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.isOpen ? 0 : getCustomizedScreenWidth(375))
        .frame(height: getCustomizedScreenHeight(812))
        
        .onAppear() {
            tags.removeAll()
            var tagSet = Set<String>()
            for work in modelData.workListData {
                for tag in work.tags.components(separatedBy: " ") {
                    tagSet.insert(tag)
                    break
                }
            }
            for tag in tagSet {
                tags.append(tag)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isOpen: false, searchClose: {
            
        })
        .environmentObject(ModelData())
    }
}

#else
struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @State var searchText = ""
    @State var tags = [String]()
    let isOpen: Bool
    let searchClose: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                UnderlinedTextField(textfieldInput: $searchText, textfieldPlaceholder: "Search", width: 343)
                    .foregroundColor(.black)
                    .padding(.bottom, getCustomizedScreenHeight(38))
                    .font(Font.custom("Pretendard-Medium", size: 32))
                
                if searchText == "" {
                    // 태그
                    HStack {
                        ForEach(tags, id: \.self) { tag in
                            Button(action: {
                                searchText = tag
                            }, label: {
                                TagBox(tag: tag, foregroundColor: .black)
                            })
                        }
                    }
                    .padding(.bottom, getCustomizedScreenWidth(22))
                } else {
                    HStack {
                        Text("'\(searchText)' 검색결과 총")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                        Text("\(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.artExhibitionListData).count + getSearchedWorkList(searchString: searchText, workList: modelData.artWorkListData).count + getSearchedGalleryList(searchString: searchText, galleryList: modelData.artGalleryListData).count)")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.blue)
                        Text("건")
                            .font(Font.custom("Pretendard-Medium", size: 20))
                            .foregroundColor(.black)
                            .offset(x: getCustomizedScreenWidth(-5))
                            .padding(.trailing, getCustomizedScreenWidth(-5))
                    }
                }
                
                if getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.artExhibitionListData).count > 0 {
                    HStack {
                        Text("전시")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.artExhibitionListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    HStack {
                        ForEach(getSearchedExhibitionList(searchString: searchText, exhibitionList: modelData.artExhibitionListData), id:\.self.exhibition_id) { exhibition in
                            NavigationLink {
                                ExhibitionView(exhibition: exhibition)
                            } label: {
                                ExhibitionHistoryListItem(exhibition: exhibition, galleryList: modelData.artGalleryListData, foregroundColor: .black)
                            }
                        }
                    }
                }
                
                if getSearchedWorkList(searchString: searchText, workList: modelData.artWorkListData).count > 0 {
                    HStack {
                        Text("작품")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedWorkList(searchString: searchText, workList: modelData.artWorkListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    WorkList(workList: getSearchedWorkList(searchString: searchText, workList: modelData.artWorkListData), foregroundColor: .black)
                        .padding(.leading, getCustomizedScreenWidth(-16))
                        .padding(.trailing, getCustomizedScreenWidth(-16))
                }
                
                if getSearchedGalleryList(searchString: searchText, galleryList: modelData.artGalleryListData).count > 0 {
                    HStack {
                        Text("전시관")
                            .font(Font.custom("Pretendard-Bold", size: 24))
                            .foregroundColor(.black)
                        
                        Text("\(getSearchedGalleryList(searchString: searchText, galleryList: modelData.artGalleryListData).count)")
                            .offset(x: getCustomizedScreenWidth(-6))
                            .offset(y: getCustomizedScreenHeight(-6))
                            .font(Font.custom("Arvo", size: 20))
                            .foregroundColor(.customBlue)
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(70))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    // Gallery List
                    HStack {
                        ForEach(getSearchedGalleryList(searchString: searchText, galleryList: modelData.artGalleryListData), id:\.self.venue_id) { gallery in
                            NavigationLink {
                                GalleryView(gallery: gallery)
                            } label: {
                                GalleryNameBox(galleryName: gallery.venue_nm, foregroundColor: .black)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .padding(.top, getCustomizedScreenHeight(108))
        .padding(.leading, getCustomizedScreenWidth(16))
        .padding(.trailing, getCustomizedScreenWidth(16))
        .padding(.bottom, getCustomizedScreenHeight(48))
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .offset(x: self.isOpen ? 0 : getCustomizedScreenWidth(375))
        .frame(height: getCustomizedScreenHeight(812))
        
        .onAppear() {
            tags.removeAll()
            var tagSet = Set<String>()
            for work in modelData.artWorkListData {
                for tag in work.artwork_tag.components(separatedBy: " ") {
                    tagSet.insert(tag)
                    break
                }
            }
            for tag in tagSet {
                tags.append(tag)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(isOpen: false, searchClose: {
            
        })
        .environmentObject(ModelData())
    }
}

#endif
