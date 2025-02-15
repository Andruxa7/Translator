//
//  TranslatorMainView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 15.02.2025.
//

import SwiftUI

struct TranslatorMainView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = TranslatorViewModel()
    
    @State private var isHuman: Bool = false
    @State private var activeAlert: ActiveAlert? = nil
    
    
    enum ActiveAlert {
        case askingForPermissionAlert, microphoneAccessAlert
    }
    
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea(edges: .all)
                
                VStack(spacing: 20) {
                    Text("Translator")
                        .font(.custom(customFont, size: 32))
                        .frame(maxWidth: UIScreen.main.bounds.width - 40)
                        .padding(.top, 20)
                    
                    HStack(spacing: 35) {
                        ZStack {
                            Text("HUMAN")
                                .fontWeight(.semibold)
                                .opacity(!isHuman ? 1 : 0)
                            Text("PET")
                                .fontWeight(.semibold)
                                .opacity(isHuman ? 1 : 0)
                        }
                        
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isHuman.toggle()
                            }
                        }) {
                            Image("arrow-swap-horizontal")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color(hex: 0x292D32))
                        }
                        
                        ZStack {
                            Text("PET")
                                .fontWeight(.semibold)
                                .opacity(!isHuman ? 1 : 0)
                            Text("HUMAN")
                                .fontWeight(.semibold)
                                .opacity(isHuman ? 1 : 0)
                        }
                    }
                    .padding(.vertical)
                    .frame(maxWidth: UIScreen.main.bounds.width - 80)
                    
                    HStack(spacing: 35) {
                        Button {
                            if vm.translatorState == .microphonePermission {
                                activeAlert = .askingForPermissionAlert
                            } else if vm.translatorState == .main {
                                vm.translatorState = .microphoneStartRecording
                            }
                        } label: {
                            switch vm.translatorState {
                            case .main:
                                VStack {
                                    Image("microphone")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(Color(hex: 0x292D32))
                                        .padding(.top, 50)
                                    Text("Start Speak")
                                        .font(.custom(customFont, size: 16))
                                        .multilineTextAlignment(.center)
                                        .frame(width: 138.0, height: 22.0)
                                        .foregroundStyle(Color(hex: 0x292D32))
                                        .padding(.vertical)
                                }
                                .frame(width: 178, height: 176)
                                .background(Color(hex: 0xFFFFFF))
                                .cornerRadius(16)
                                .shadow(radius: 5)
                            case .microphoneStartRecording:
                                VStack {
                                    LottieMicrophoneView()
                                        .padding(.bottom, 8)
                                        .frame(width: 170, height: 170)
                                }
                                .frame(width: 178, height: 176)
                                .background(Color(hex: 0xFFFFFF))
                                .cornerRadius(16)
                                .shadow(radius: 5)
                            case .microphonePermission:
                                VStack {
                                    Image("microphone")
                                        .resizable()
                                        .renderingMode(.template)
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundStyle(Color(hex: 0x292D32))
                                        .padding(.top, 50)
                                    Text("Start Speak")
                                        .font(.custom(customFont, size: 16))
                                        .multilineTextAlignment(.center)
                                        .frame(width: 138.0, height: 22.0)
                                        .foregroundStyle(Color(hex: 0x292D32))
                                        .padding(.vertical)
                                }
                                .frame(width: 178, height: 176)
                                .background(Color(hex: 0xFFFFFF))
                                .cornerRadius(16)
                                .shadow(radius: 5)
                            }
                        }
                        
                        VStack {
                            ForEach(PetOptionsViewModel.allCases) { option in
                                PetRowView(
                                    imageName: option.imageName,
                                    iconColor: option.iconColor,
                                    petOption: option,
                                    selectedPet: $vm.selectedPet)
                            }
                            .padding(.vertical, 5)
                        }
                        .frame(width: 107, height: 176)
                        .background(Color(hex: 0xFFFFFF))
                        .cornerRadius(16)
                        .shadow(radius: 5)
                    }
                    .padding(.top, 40)
                    .padding(.vertical, 20)
                    .frame(maxWidth: UIScreen.main.bounds.width - 70)
                    
                    Image(vm.selectedPet.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 184, height: 184)
                    
                    Spacer()
                }
                .blur(radius: vm.showLoadingOverlay ? 7 : 0)
                
                if vm.showLoadingOverlay {
                    OverlayProgressContainer(isShowing: .constant(true)) {
                        Color.clear
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .environmentObject(vm)
        .alert(isPresented: Binding<Bool>(
            get: { activeAlert != nil },
            set: { _ in
                activeAlert = nil
            }
        )) {
            switch activeAlert {
            case .askingForPermissionAlert:
                return Alert(
                    title: Text("\"Translator App\" is asking for permission to access your microphone"),
                    message: Text("Allow access to your microphone to use the app's features"),
                    primaryButton: .default(Text("Allow Access"), action: {
                        vm.translatorState = .main
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            activeAlert = .microphoneAccessAlert
                        }
                    }),
                    secondaryButton: .cancel(Text("Don't Allow"))
                )
            case .microphoneAccessAlert:
                return Alert(
                    title: Text("Enable Microphone Access"),
                    message: Text("Please allow access to your microphone to use the app's features"),
                    primaryButton: .default(Text("Settings"), action: {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                        vm.translatorState = .microphoneStartRecording
                        dismiss()
                    }),
                    secondaryButton: .cancel({
                        vm.translatorState = .microphonePermission
                        dismiss()
                    })
                )
            case .none:
                return Alert(title: Text("Error"))
            }
        }
    }
}

#Preview {
    TranslatorMainView()
}
