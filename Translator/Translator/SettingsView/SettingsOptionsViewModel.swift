//
//  SettingsOptionsViewModel.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import Foundation
import SwiftUI

enum SettingsOptionsViewModel: Int, Identifiable, CaseIterable {
    case rateUs
    case shareApp
    case contactUs
    case restorePurchases
    case privacyPolicy
    case termsOfUse
    
    var rawTitle: String {
        switch self {
        case .rateUs: return "Rate Us"
        case .shareApp: return "Share App"
        case .contactUs: return "Contact Us"
        case .restorePurchases: return "Restore Purchases"
        case .privacyPolicy: return "Privacy Policy"
        case .termsOfUse: return "Terms of Use"
        }
    }
    
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .rateUs: RateUsView()
        case .shareApp: ShareAppView()
        case .contactUs: ContactUsView()
        case .restorePurchases: RestorePurchasesView()
        case .privacyPolicy: PrivacyPolicyView()
        case .termsOfUse: TermsOfUseView()
        }
    }
    
    var id: Int { return rawValue }
}
