//
//  MainTabbedView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case translator = 0
    case clicker
    
    var title: String {
        switch self {
        case .translator:
            return "Translator"
        case .clicker:
            return "Clicker"
        }
    }
    
    var iconName: String {
        switch self {
        case .translator:
            return "messages"
        case .clicker:
            return "gear"
        }
    }
}

struct MainTabbedView: View {
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                TranslatorMainView()
                    .tag(0)
                
                SettingsView()
                    .tag(1)
            }
            
            ZStack {
                HStack(spacing: 30) {
                    ForEach((TabbedItems.allCases), id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item.rawValue))
                        }
                    }
                }
                .padding(6)
            }
            .frame(width: 216, height: 82)
            .background(Color(hex: 0xFFFFFF))
            .cornerRadius(16)
            .shadow(radius: 5)
            .padding(16)
        }
    }
}

extension MainTabbedView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(isActive ? Color(hex: 0x292D32) : .gray)
                
                Text(title)
                    .font(.custom(customFont, size: 12))
                    .multilineTextAlignment(.center)
                    .frame(width: 63.0, height: 16)
                    .foregroundStyle(isActive ? Color(hex: 0x292D32) : .gray)
            }
        }
    }
}

#Preview {
    MainTabbedView()
}
