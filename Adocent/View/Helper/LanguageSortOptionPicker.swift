//
//  LanguageSortOptionPicker.swift
//  Adocent
//
//  Created by 김찬형 on 2022/11/10.
//

import SwiftUI

struct LanguageSortOptionPicker: View {
    @Binding var selectedLanguage: String
    @Binding var selectedSortOrder: String
    var foregroundColor: Color

    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                .foregroundColor(foregroundColor)
            Menu {
                Picker(selection: $selectedLanguage, label: EmptyView()) {
                    ForEach(languages, id: \.self) {
                        Text($0)
                    }
                }
            } label: {
                Text(selectedLanguage)
                    .foregroundColor(foregroundColor)
                    .font(Font.custom("Pretendard-Medium", size: 16))
                Image("downArrow")
                    .resizable()
                    .frame(width: getCustomizedScreenWidth(12), height: getCustomizedScreenHeight(12))
                    .foregroundColor(foregroundColor)
            }
            
            Spacer()
            
            if selectedSortOrder != "" {
                Menu {
                    Picker(selection: $selectedSortOrder, label: EmptyView()) {
                        ForEach(sortOrder, id: \.self) {
                            Text($0)
                        }
                    }
                } label: {
                    Image("sortIcon")
                        .resizable()
                        .frame(width: getCustomizedScreenWidth(28), height: getCustomizedScreenHeight(28))
                        .foregroundColor(foregroundColor)
                }
            }
        }
    }
}

struct LanguageSortOptionPicker_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSortOptionPicker(selectedLanguage: .constant("KR"), selectedSortOrder: .constant("추천"), foregroundColor: .white)
    }
}
