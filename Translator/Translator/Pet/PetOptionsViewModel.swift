//
//  PetOptionsViewModel.swift
//  Translator
//
//  Created by Andrii Stetsenko on 14.02.2025.
//

import Foundation
import SwiftUI

enum PetOptionsViewModel: Int, Identifiable, CaseIterable {
    case cat
    case dog
    
    var imageName: String {
        switch self {
        case .cat: return "cat"
        case .dog: return "dog"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .cat: return Color(hex: 0xD1E7FC)
        case .dog: return Color(hex: 0xECFBC7)
        }
    }
    
    var id: Int { return rawValue }
}
