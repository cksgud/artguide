//
//  LoginView.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/11.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var modelData: ModelData
    @State var appleSignInDelegates: SignInWithAppleDelegates! = nil
    @State var appleLoginSuccess = false
    @State var userNickname = ""
    
    var body: some View {
        if appleLoginSuccess {
            MainView(galleryList: [Gallery](), exhibitionList: [Exhibition](), workList: [Work](), docentTourList: [DocentTour]())
                .environmentObject(ModelData())
        } else {
            ZStack {
                Image("logo")
                    .renderingMode(.template)
                    .foregroundColor(.black)
                
                UnderlinedTextField(textfieldInput: $userNickname, textfieldPlaceholder: "닉네임을 입력해주세요", width: 300)
                    .foregroundColor(.black)
                    .padding(.top, getCustomizedScreenHeight(120))
                    .font(Font.custom("Pretendard-Medium", size: 20))
                
                SignInWithAppleButton()
                    .frame(width: getCustomizedScreenWidth(280), height: getCustomizedScreenHeight(60))
                    .onTapGesture(perform: showAppleLogin)
                    .padding(.top, getCustomizedScreenHeight(300))
                    .opacity(userNickname == "" ? 0.5 : 1)
            }
        }
    }
    
    private func showAppleLogin() {
        if userNickname == "" {
            return
        }
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        performSignIn(using: [request])
    }
    
    private func performSignIn(using requests: [ASAuthorizationRequest]) {
        appleSignInDelegates = SignInWithAppleDelegates() { success in
            if success {
                appleLoginSuccess = true
                UserDefaults.standard.set(userNickname, forKey: "UserNickname")
                print("performSignIn success, \(String(describing: UserDefaults.standard.string(forKey: "UserID"))) 유저 로그인 성공")
            } else {
                print("performSignIn error")
            }
        }
        
        let controller = ASAuthorizationController(authorizationRequests: requests)
        controller.delegate = appleSignInDelegates
        
        // 애플 로그인 팝업 출력
        controller.performRequests()
    }
    
    private func performExistingAccountSetupFlows() {
        #if !targetEnvironment(simulator)
        
        let requests = [
            ASAuthorizationAppleIDProvider().createRequest(),
            ASAuthorizationPasswordProvider().createRequest()
        ]
        
        performSignIn(using: requests)
        #endif
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appleSignInDelegates: nil)
    }
}
