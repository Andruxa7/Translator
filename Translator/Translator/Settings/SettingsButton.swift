//
//  SettingsButton.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct SettingsButton: View {
    let option: SettingsOptionsViewModel
    
    var body: some View {
        NavigationLink(destination: option.destinationView()) {
            HStack {
                Text(option.rawTitle)
                    .font(.custom(customFont, size: 16))
                    .foregroundStyle(Color(hex: 0x393736))
                Spacer()
                Image("arrow-right")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color(hex: 0x393736))
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 32, height: 50)
            .background(Color(hex: 0xD6DCFF))
            .cornerRadius(20)
        }
    }
}

#Preview {
    SettingsButton(option: .contactUs)
}
