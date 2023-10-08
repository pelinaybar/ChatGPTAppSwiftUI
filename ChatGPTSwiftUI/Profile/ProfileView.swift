//
//  ProfileView.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 8.10.2023.
//

import SwiftUI

struct ProfileView: View {
    @State var apiKey: String = UserDefaults.standard.string(forKey: "openai_api_key") ?? ""
    var body: some View {
        List{
            Section("OpenAI API Key"){
                TextField("Enter key", text: $apiKey){
                    UserDefaults.standard.set(apiKey, forKey: "openai_api_key")
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
