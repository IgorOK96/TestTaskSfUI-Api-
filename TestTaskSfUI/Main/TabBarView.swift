//
//  TabBarView.swift
//  TestTaskSwiftUI
//
//  Created by user246073 on 11/7/24.
//

import SwiftUI

struct TabBarView: View {
    @StateObject private var networkMonitor = NetworkMonitor() // Connection with network monitoring

    @State private var selectedTab = 0
    @State private var isKeyboardVisible = false
    
    var body: some View {
        if networkMonitor.isConnected {
            
            VStack(spacing: 0) {
                TabView(selection: $selectedTab) {
                    UsersView()
                        .tag(0)
                    SignUpView()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide page indicator
                
                if !isKeyboardVisible {
                    // Custom horizontal tab bar
                    HStack(spacing: 0) {
                        TabButton(
                            iconName: "person.3.sequence.fill",
                            title: "Users",
                            isSelected: selectedTab == 0
                        ) {
                            selectedTab = 0
                        }
                        .frame(maxWidth: .infinity)
                        
                        TabButton(
                            iconName: "person.crop.circle.fill.badge.plus",
                            title: "Sign up",
                            isSelected: selectedTab == 1
                        ) {
                            selectedTab = 1
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 40)
                    .offset(y: 10)
                    .background(Color(.systemGray6))
                    .zIndex(1) // Set high z-index for the tab bar
                }
            }.navigationBarBackButtonHidden(true)
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
                    isKeyboardVisible = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    isKeyboardVisible = false
                }
        } else {
            NoConnectionView(networkMonitor: networkMonitor)
        }
        
    }
}
