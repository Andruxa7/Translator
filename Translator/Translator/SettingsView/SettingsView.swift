//
//  SettingsView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    ScrollView {
                        VStack(spacing: 14) {
                            ForEach(SettingsOptionsViewModel.allCases) { option in
                                SettingsButton(option: option)
                            }
                        }
                        .padding(.top, 20)
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .font(.custom(customFont, size: 32))
                        .padding(.top, 70)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
