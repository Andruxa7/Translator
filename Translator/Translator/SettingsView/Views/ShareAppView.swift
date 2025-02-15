//
//  ShareAppView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct ShareAppView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundGradient
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    Text("Share App View")
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.green.opacity(0.4))
                .foregroundColor(Color.primary)
                .cornerRadius(20)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .foregroundStyle(.white)
                            
                            Image("close")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.top, 30)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Share App")
                        .font(.custom(customFont, size: 32))
                        .padding(.top, 70)
                }
            }
        }
    }
}

#Preview {
    ShareAppView()
}
