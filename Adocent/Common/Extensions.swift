//
//  Extensions.swift
//  Adocent
//
//  Created by 김찬형 on 2022/09/14.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: getCustomizedScreenHeight(1)).padding(.top, 35).foregroundColor(.black).opacity(0.3))
            .padding(10)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension Color {
    static let commentaryBlockBackgroundColor = Color(red: 56 / 255, green: 64 / 255, blue: 70 / 255)
    static let customBlue = Color(red: 31 / 255, green: 89 / 255, blue: 239 / 255)
    static let customWhite = Color(red: 0.988, green: 0.995, blue: 1)
    static let customGray = Color(red: 204 / 255, green: 204 / 255, blue: 204 / 255)
    static let customWhiteForUnselected = Color(red: 0.988, green: 0.995, blue: 1).opacity(0.3)
    static let customGreen = Color(red: 28 / 255, green: 224 / 255, blue: 47 / 255)
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
    static let gold = Color(red: 255 / 255, green: 215 / 255, blue: 0 / 255)
    static let silver = Color(red: 192 / 255, green: 192 / 255, blue: 192 / 255)
    static let bronze = Color(red: 205 / 255, green: 127 / 255, blue: 50 / 255)
}

extension UIScreen {
   static let screenWidth = Float(UIScreen.main.bounds.size.width)
   static let screenHeight = Float(UIScreen.main.bounds.size.height)
}


extension View {
    func border(isSelected: Bool, tabOrder: TabOrder, width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(isSelected: isSelected, tabOrder: tabOrder, width: width, edges: edges).foregroundColor(color))
    }
}

extension URLImage {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .scaledToFill()
            .frame(width: getCustomizedScreenWidth(359), height: getCustomizedScreenHeight(264))
            .clipped()
        }
    }
}
