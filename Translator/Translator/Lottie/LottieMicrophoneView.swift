//
//  LottieMicrophoneView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI
import Lottie

struct LottieMicrophoneView: View {
    
    @EnvironmentObject var vm: TranslatorViewModel
    
    @State private var isAnimating = false
    private let animationView = LottieAnimationView()
    @State private var playbackMode: LottiePlaybackMode = .paused
    
    
    var body: some View {
        
        NavigationStack(path: $vm.navPath) {
            VStack {
                LottieView(animation: .named("microphone"))
                  .playbackMode(playbackMode)
                
                Button(action: {
                    if isAnimating {
                        stopAnimation()
                    } else {
                        startAnimation()
                    }
                    isAnimating.toggle()
                }) {
                    Text(isAnimating ? "Recording..." : "Start recording")
                        .frame(width: 120, height: 30)
                        .padding()
                        .background(isAnimating ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .onAppear {
                setupAnimation()
            }
        }
        .navigationBarBackButtonHidden()
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
    
    private func setupAnimation() {
        if let animation = LottieAnimation.named("microphone") {
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
        }
    }
    
    private func startAnimation() {
        playbackMode = .playing(.fromProgress(0, toProgress: 1.0, loopMode: .loop))
    }
    
    private func stopAnimation() {
        playbackMode = .paused
        vm.goToResultView()
    }
}

#Preview {
    LottieMicrophoneView()
        .environmentObject(TranslatorViewModel())
}
