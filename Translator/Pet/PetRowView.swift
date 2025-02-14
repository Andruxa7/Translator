//
//  PetRowView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 14.02.2025.
//

import SwiftUI

struct PetRowView: View {
    
    var imageName: String
    var iconColor: Color
    var petOption: PetOptionsViewModel
    
    @Binding var selectedPet: PetOptionsViewModel
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedPet = petOption
            }
        }) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(iconColor)
                .frame(width: 70, height: 70)
                .overlay(
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                )
        }
    }
}

#Preview {
    PetRowView(
        imageName: "cat",
        iconColor: Color(hex: 0xD1E7FC),
        petOption: .cat,
        selectedPet: .constant(.cat))
}
