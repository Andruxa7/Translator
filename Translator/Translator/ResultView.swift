//
//  ResultView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var vm: TranslatorViewModel
    
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    Spacer()
                    
                    SpeechBubbleView(text: vm.getRandomPhrase())
                        .padding(.bottom, 40)
                    
                    Image(vm.selectedPet.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 184, height: 184)
                    
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            vm.navPath = .init()
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
                    Text("Result")
                        .font(.custom(customFont, size: 32))
                        .padding(.top, 70)
                }
            }
            .navigationDestination(for: TranslatorViewModel.NavigationTarget.self) { target in
                switch target {
                    case .resultScreen:
                    ResultView()
                        .environmentObject(vm)
                case .translationScreen:
                    EmptyView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SpeechBubbleView: View {
    var text: String
    
    var body: some View {
        ZStack {
            BubbleShape()
                .fill(Color(hex: 0xD6DCFF))
                .frame(width: 291, height: 200)
                .shadow(radius: 4)
            
            Text(text)
                .font(.custom(customFont, size: 14))
                .foregroundStyle(Color(hex: 0x292D32))
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)
        }
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let cornerRadius: CGFloat = 20
        let tailWidth: CGFloat = 20
        let tailHeight: CGFloat = 70
        let tailOffsetX: CGFloat = 220
        
        path.addRoundedRect(
            in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height - tailHeight),
            cornerSize: CGSize(width: cornerRadius, height: cornerRadius)
        )
        
        path.move(to: CGPoint(x: tailOffsetX, y: rect.height - tailHeight))
        path.addLine(to: CGPoint(x: tailOffsetX + (tailWidth / 2), y: rect.height))
        path.addLine(to: CGPoint(x: tailOffsetX + tailWidth, y: rect.height - tailHeight))
        
        return path
    }
}

#Preview {
    ResultView()
        .environmentObject(TranslatorViewModel())
}
