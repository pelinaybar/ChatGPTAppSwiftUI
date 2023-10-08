//
//  ChatGPTSwiftUIApp.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 7.10.2023.
//

import SwiftUI
import SwiftData

@main
struct ChatGPTSwiftUIApp: App {
    @ObservedObject var appState : AppState = AppState()
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                NavigationStack(path: $appState.navigationPath) {
                    ChatListView()
                        .environmentObject(appState)
                }
            }else{
                AuthView()
                    .environmentObject(appState)
            }
        }
    }
}
