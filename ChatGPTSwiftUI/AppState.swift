//
//  AppState.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 7.10.2023.
//

import Foundation
import FirebaseAuth
import SwiftUI
import Firebase

class AppState : ObservableObject {
    @Published var currentUser : User?
    @Published var navigationPath = NavigationPath()
    var isLoggedIn: Bool{
        return currentUser != nil 
    }
    init() {
        FirebaseApp.configure()
        if let currentUser = Auth.auth().currentUser{
            self.currentUser = currentUser
        }
        
    }
}
