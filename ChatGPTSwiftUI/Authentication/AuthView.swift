//
//  AuthView.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 7.10.2023.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var viewModel : AuthViewModel = AuthViewModel()
    @EnvironmentObject var appState : AppState
    var body: some View {
        VStack{
            Text("ChatGPT Ios App")
                .padding()
                .font(.title)
                .bold()
                .background(Color.black.opacity(0.01))
                .clipShape(RoundedRectangle(cornerRadius: 1))
            TextField("Email: ",text: $viewModel.emailText)
                .padding()
                .background(Color.blue.opacity(0.1))
                .textInputAutocapitalization(.never)
                .clipShape(RoundedRectangle(cornerRadius: 23))
            if viewModel.isPasswordVisible{
                SecureField("Password: ",text: $viewModel.passwordText)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .textInputAutocapitalization(.never)
                    .clipShape(RoundedRectangle(cornerRadius: 23))
            }
            if viewModel.isLoading {
                ProgressView()
            }else{
                Button{
                    viewModel.authenticate(appState: appState)
                } label : {
                    Text(viewModel.userExists ? "Login In" : " Create Account")
                }
                .padding()
                .foregroundStyle(.white)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            }
            }
        .padding()
    }
}

#Preview {
    AuthView()
}
