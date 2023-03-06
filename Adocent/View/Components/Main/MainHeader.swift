//
//  MainHeader.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/19.
//

import SwiftUI
import CodeScanner

struct MainHeader: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.presentationMode) var presentationMode
    @State var isGNBMenuViewOpen: Bool = false
    @State var isSearchViewOpen: Bool = false
    @State var isKeyboardHidden: Bool = false
    @State private var isShowingScanner = false
    var showMainLogo: Bool
    var foregroundColor: Color
    @Binding var disableParentScroll: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            GNBMenuView(isOpen: self.isGNBMenuViewOpen,
                     menuClose: self.toggleGNBMenuViewOpen)
            
            SearchView(isOpen: self.isSearchViewOpen,
                       searchClose: self.toggleSearchViewOpen)
            
            if !isGNBMenuViewOpen {
                if showMainLogo {
                    HStack {
                        NavigationLink {
                            MainView(galleryList: [Gallery](), exhibitionList: [Exhibition](), workList: [Work](), docentTourList: [DocentTour]())
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Image("logo")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(foregroundColor)
                                .frame(width: getCustomizedScreenWidth(144), height: getCustomizedScreenHeight(20))
                        }
                        
                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(64))
                    .padding(.leading, getCustomizedScreenWidth(16))
                } else {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("backButton")
                                .renderingMode(.template)
                                .foregroundColor(foregroundColor)
                        })

                        Spacer()
                    }
                    .padding(.top, getCustomizedScreenHeight(64))
                    .padding(.leading, getCustomizedScreenWidth(16))
                }
                
                HStack {
                    Spacer()
                    if !isSearchViewOpen {
                        Button(action: {
                            self.toggleSearchViewOpen()
                            disableParentScroll.toggle()
                        }, label: {
                            Image("searchIcon")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(foregroundColor)
                                .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        })
                    } else {
                        // QR 코드 스캐너
                        NavigationLink {
                            QRCodeScanView()
                        } label: {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: getCustomizedScreenWidth(35), height: getCustomizedScreenHeight(28))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.top, getCustomizedScreenHeight(60))
                .padding(.trailing, getCustomizedScreenWidth(68))
            }
            
            HStack {
                Spacer()
                
                if isGNBMenuViewOpen {
                    Image("menuActivated")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        .onTapGesture {
                            self.toggleGNBMenuViewOpen()
                            disableParentScroll = false
                        }
                } else {
                    if isSearchViewOpen {
                        Image("menuActivated")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                            .onTapGesture {
                                self.toggleSearchViewOpen()
                                hideKeyboard()
                                disableParentScroll = false
                            }
                    } else {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(foregroundColor)
                            .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                            .onTapGesture {
                                self.toggleGNBMenuViewOpen()
                                disableParentScroll = true
                            }
                    }
                }
            }
            .padding(.top, getCustomizedScreenHeight(60))
            .padding(.trailing, getCustomizedScreenWidth(16))
        }
    }
    
    func toggleGNBMenuViewOpen() {
        self.isGNBMenuViewOpen.toggle()
    }
    
    func toggleSearchViewOpen() {
        self.isSearchViewOpen.toggle()
    }
}

//struct MainHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        MainHeader(showMainLogo: true, foregroundColor: Color.black, disableParentScroll: false)
//            .environmentObject(ModelData())
//    }
//}
