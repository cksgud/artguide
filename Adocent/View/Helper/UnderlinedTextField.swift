//
//  UnderlinedTextField.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/01.
//

import SwiftUI

struct UnderlinedTextField: View {
    @Binding var textfieldInput: String
    var textfieldPlaceholder: String
    var width: Float
    
    var body: some View {
        TextField (
            "",
            text: $textfieldInput
        )
        .placeholder(when: textfieldInput.isEmpty, alignment: .leading) {
            Text(textfieldPlaceholder).foregroundColor(.black).opacity(0.1)
        }
        .underlineTextField()
        .frame(width: getCustomizedScreenWidth(width))
        .accentColor(.black)
        .multilineTextAlignment(.leading)
        
    }
}

//struct UnderlinedTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        UnderlinedTextField(textfieldInput: "검색", textfieldPlaceholder: "Search")
//    }
//}
