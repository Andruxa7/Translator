//
//  TranslatorViewModel.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import Foundation
import SwiftUI

final class TranslatorViewModel: ObservableObject {
    
    @Published var navPath = NavigationPath()
    @Published var navigationTarget: NavigationTarget? = nil
    @Published var translatorState: TranslatorState = .microphonePermission
    @Published var showLoadingOverlay = false
    @Published var selectedPet: PetOptionsViewModel = .cat
    
    enum NavigationTarget: Hashable {
        case resultScreen
        case translationScreen
    }
    
    enum TranslatorState {
        case main
        case microphonePermission
        case microphoneStartRecording
    }
    
    func getRandomPhrase() -> String {
        let phrases: [String] = [
            "I’m hungry, feed me!",
            "What are you doing, human?",
            "I want to go for a walk!",
            "I'm thirsty, pour me some water!",
            "Play with me!"
        ]
        return phrases.randomElement() ?? "No phrases available"
    }
    
    func goToResultView() {
        showLoadingOverlay = true
        
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 2_500_000_000)
            
            self.showLoadingOverlay = false
            
            withAnimation {
                self.navPath.append(TranslatorViewModel.NavigationTarget.resultScreen)
            }
        }
    }
}
