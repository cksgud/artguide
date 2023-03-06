//
//  SignInWithAppleButton.swift
//  Manbo
//
//  Created by 김찬형 on 2022/09/06.
//

import SwiftUI
import AuthenticationServices

final class SignInWithAppleButton: UIViewRepresentable {
  func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
    return ASAuthorizationAppleIDButton()
  }
  
  func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    
  }
}
