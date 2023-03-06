//
//  DocentTourView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/21.
//

import SwiftUI

#if LOCAL_API
struct DocentTourView: View {
    @EnvironmentObject var modelData: ModelData
    var docentTour: DocentTour
    @State var seeMore = false
    @State var number = ""
    @State var time = ""
    @State var disableParentScroll = false
    @State var workList = [Work]()
    @State var selectedLanguage = languages.first!
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: false, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    URLImage(withURL: docentTour.image_url)
                        .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(375))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                    
                    HStack {
                        Text(docentTour.title)
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    HStack {
                        LanguageSortOptionPicker(selectedLanguage: $selectedLanguage, selectedSortOrder: Binding.constant(""), foregroundColor: .white)
                        
                        Spacer()
                        
                        Image("workViewsIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text(number)
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                        
                        Image("clockIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text(time)
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(15))
                    
                    Text(!seeMore ?
                         "\(docentTour.commentary.prefix(upTo: docentTour.commentary.index(docentTour.commentary.startIndex, offsetBy: docentTour.commentary.count / 2))) ..."
                         : docentTour.commentary)
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
                        ImageButton(imageName: "downloadIcon")
                        ImageButton(imageName: "heartIcon")
                        NavigationLink {
                            DocentTourDetailView(work: workList.isEmpty ? Work() : workList.first!, workList: workList)
                        } label: {
                            WhiteButton(text: "Start Tour", width: 248)
                                .padding(.leading, getCustomizedScreenWidth(-14))
                        }
                    }
                    .padding(.top, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            if let tourNumberString = docentTour.tour_guide.firstIndex(of: "개") {
                if let tourNumber = docentTour.tour_guide[...tourNumberString].components(separatedBy: " ").last {
                    number = tourNumber
                }
            }
            
            if let tourTimeString = docentTour.tour_guide.firstIndex(of: "분") {
                if let tourTime = docentTour.tour_guide[...tourTimeString].components(separatedBy: " ").last {
                    time = tourTime
                }
            }
            
            #if NOSERVER
                workList = modelData.workListData
            #else
                if let url = URL(string: "\(docentTourListAPI_forDocentTourId)\(docentTour.id)") {
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

struct DocentTourView_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourView(docentTour: DocentTour())
            .environmentObject(ModelData())
    }
}

#else
struct DocentTourView: View {
    @EnvironmentObject var modelData: ModelData
    var docentTour: DocentTour
    @State var seeMore = false
    @State var number = ""
    @State var time = ""
    @State var disableParentScroll = false
    @State var workList = [Work]()
    @State var selectedLanguage = languages.first!
    
    var body: some View {
        ScrollView(disableParentScroll ? [] : .vertical) {
            ZStack(alignment: .top) {
                MainHeader(showMainLogo: false, foregroundColor: .white, disableParentScroll: $disableParentScroll)
                    .zIndex(1)
                
                VStack(alignment: .leading) {
                    URLImage(withURL: adminAddress + docentTour.artwork_img_path)
                        .frame(width: getCustomizedScreenWidth(375), height: getCustomizedScreenHeight(375))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                    
                    HStack {
                        Text(docentTour.artwork_title)
                            .font(Font.custom("Pretendard-Medium", size: 32))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(22))
                    
                    HStack {
                        LanguageSortOptionPicker(selectedLanguage: $selectedLanguage, selectedSortOrder: Binding.constant(""), foregroundColor: .white)
                        
                        Spacer()
                        
                        Image("workViewsIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text(number)
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                        
                        Image("clockIcon")
                            .resizable()
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        Text(time)
                            .font(Font.custom("Pretendard-Medium", size: 16))
                            .foregroundColor(.white)
                            .padding(.leading, getCustomizedScreenWidth(-4))
                            .offset(x: getCustomizedScreenWidth(-4))
                    }
                    .padding(.leading, getCustomizedScreenWidth(16))
                    .padding(.trailing, getCustomizedScreenWidth(16))
                    .padding(.bottom, getCustomizedScreenHeight(15))
                    
                    Text(!seeMore ?
                         "\(docentTour.artwork_text.prefix(upTo: docentTour.artwork_text.index(docentTour.artwork_text.startIndex, offsetBy: docentTour.artwork_text.count / 2))) ..."
                         : docentTour.artwork_text)
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
                        ImageButton(imageName: "downloadIcon")
                        ImageButton(imageName: "heartIcon")
                        NavigationLink {
                            DocentTourDetailView(work: workList.isEmpty ? Work() : workList.first!, workList: workList)
                        } label: {
                            WhiteButton(text: "Start Tour", width: 248)
                                .padding(.leading, getCustomizedScreenWidth(-14))
                        }
                    }
                    .padding(.top, getCustomizedScreenHeight(22))
                    .padding(.leading, getCustomizedScreenWidth(16))
                    
                    Footer(foregroundColor: .white)
                        .padding(.top, getCustomizedScreenHeight(70))
                        .padding(.leading, getCustomizedScreenWidth(16))
                        .padding(.trailing, getCustomizedScreenWidth(16))
                        .padding(.bottom, getCustomizedScreenHeight(38))
                }
            }
        }
        .background(Color.black)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            workList = modelData.artWorkListData
            
            if let tourNumberString = docentTour.artwork_text.firstIndex(of: "개") {
                if let tourNumber = docentTour.artwork_text[...tourNumberString].components(separatedBy: " ").last {
                    number = tourNumber
                }
            }
            
            if let tourTimeString = docentTour.artwork_text.firstIndex(of: "분") {
                if let tourTime = docentTour.artwork_text[...tourTimeString].components(separatedBy: " ").last {
                    time = tourTime
                }
            }
            
            number = "해설 5개"
            time = "총 8분"
        }
    }
}

struct DocentTourView_Previews: PreviewProvider {
    static var previews: some View {
        DocentTourView(docentTour: DocentTour())
            .environmentObject(ModelData())
    }
}
#endif
