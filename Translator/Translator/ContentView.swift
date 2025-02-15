//
//  ContentView.swift
//  Translator
//
//  Created by Andrii Stetsenko on 14.02.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: TabbedItems = .translator
    
    var body: some View {
        NavigationStack {
            MainTabbedView(selectedTab: selectedTab.rawValue)
        }
    }
}

#Preview {
    ContentView()
}
