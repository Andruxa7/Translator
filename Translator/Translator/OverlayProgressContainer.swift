//
//  OverlayProgressContainer.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct OverlayProgressContainer<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 3 : 0)
                VStack {
                    Text("Process of translation...")
                        .font(.custom(customFont, size: 14))
                    ProgressView()
                        .progressViewStyle(.circular)
                }
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.height / 5)
                .background(Color.green.opacity(0.5))
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .opacity(self.isShowing ? 1 : 0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.container,edges: .all)
        }
    }
}

struct OverlayProgressContainer_Previews: PreviewProvider {
    static var previews: some View {
        OverlayProgressContainer(isShowing: .constant(true)) {
            Color.clear
        }
    }
}
