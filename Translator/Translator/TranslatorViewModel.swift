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
    @Published var showLoadingOverlay = false
    @Published var selectedPet: PetOptionsViewModel = .cat
    
    enum NavigationTarget: Hashable {
        case resultScreen
        case translationScreen
    }
}
